//
//  dismissDetailTransition.m
//  Day 4 Photo Boomper App
//
//  Created by Nazifa Baktybayeva on 18.06.15.
//  Copyright (c) 2015 Nazifa Baktybayeva. All rights reserved.
//

#import "dismissDetailTransition.h"

@implementation dismissDetailTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.1;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *detailVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //detailVC.view.alpha = 0.0;
    [UIView animateWithDuration:0.1 animations:^{
        detailVC.view.alpha = 1.0;
    }completion:^(BOOL finished) {
        [detailVC.view removeFromSuperview];
        [transitionContext completeTransition:YES];
  
    }];
}
@end
