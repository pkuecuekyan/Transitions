//
//  PHIAnimationController.m
//  Transitions
//
//  Created by Philipp Kuecuekyan on 7/9/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
//

#import "PHIAnimationController.h"

@implementation PHIAnimationController

- (id)init {
    if (self = [super init]) {
        self.presentationDuration = self.dismissalDuration = 1.0f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.isPresenting ? self.presentationDuration : self.dismissalDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    [self animateTransition:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
}

@end
