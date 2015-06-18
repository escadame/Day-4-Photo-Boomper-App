//
//  PresentDetailTransition.m
//  Day 4 Photo Boomper App
//
//  Created by Nazifa Baktybayeva on 18.06.15.
//  Copyright (c) 2015 Nazifa Baktybayeva. All rights reserved.
//

#import "PresentDetailTransition.h"

@implementation PresentDetailTransition


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.1;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *detaiVC = [transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    detaiVC.view.alpha = 0.0;
    
    CGRect frame = containerView.bounds;
    frame.origin.y += 20;
    frame.size.height -= 20;
    
    detaiVC.view.frame = frame;
    [containerView addSubview:detaiVC.view];
    
    [UIView animateWithDuration:0.1 animations:^{
        detaiVC.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
