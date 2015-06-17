//
//  PhotoController.h
//  Day 4 Photo Boomper App
//
//  Created by Nazifa Baktybayeva on 17.06.15.
//  Copyright (c) 2015 Nazifa Baktybayeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoController : NSObject

+ (void) imageForPhoto: (NSDictionary *) photo size: (NSString *) size completion: (void(^) (UIImage *image)) completion;

@end
