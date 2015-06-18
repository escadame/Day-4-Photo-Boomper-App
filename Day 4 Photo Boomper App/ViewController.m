//
//  ViewController.m
//  Day 4 Photo Boomper App
//
//  Created by Nazifa Baktybayeva on 17.06.15.
//  Copyright (c) 2015 Nazifa Baktybayeva. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import <SimpleAuth/SimpleAuth.h>
#import "DetailViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSMutableArray *photos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];
    if (self.accessToken == nil) {
       // [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error) {
            self.accessToken = responseObject[@"credentials"][@"token"];
            [userDefaults setObject:self.accessToken forKey:@"accessToken"];
            [userDefaults synchronize];
            NSLog(@"saved credentials");
            [self downloadImages];
    }] ;
    }else {
         NSLog(@"using previous credentials");
        [self downloadImages];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - helper methods
-(void) downloadImages {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/Kazakhstan/media/recent?access_token=%@", self.accessToken];
   // NSLog(@"%@", urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response is: %@", response);
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"Response dicitonary is: %@", responseDictionary);
        self.photos = responseDictionary [@"data"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
    [task resume];
}

# pragma mark - UICollectionView Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //cell.imageView.image = [UIImage imageNamed:@"MSG-3_first_image_7aug12_H.jpg"];
    NSDictionary *photo = self.photos[indexPath.row];
    cell.photo = photo;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *photo = self.photos [indexPath.row];
    
    DetailViewController *viewController = [DetailViewController new];
    viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    viewController.photo = photo;
    
    [self presentViewController:viewController  animated:YES completion:nil];
    
}

@end
