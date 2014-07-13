//
//  PHIDropAnimationController.m
//  Transitions
//
//  Created by Philipp Kuecuekyan on 7/10/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
//

#import "PHIDropAnimationController.h"

@implementation PHIDropAnimationController

- (instancetype) init {
    self = [super init];
    if (self){
        self.presentationDuration = 1.0;
        self.dismissalDuration = 0.5;
    }
    
    return self;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (self.isPresenting) {
        [self executeDropInAnimation:transitionContext];
    } else {
        [self executeDropOutAnimation:transitionContext];
    }
    
}

-(void)executeDropInAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
   
    // Hold onto views, VCs, context, frames
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [fromViewController view];
    UIView *toView = [toViewController view];
    
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    // Create a transition background view
    UIView *backgroundView = [[UIView alloc] initWithFrame:[transitionContext initialFrameForViewController:fromViewController]];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    [containerView addSubview:backgroundView];

    // Take a snapshot of the presenting view
    CGRect fromSnapshotRect = fromView.bounds;
    UIView *fromSnapshotView = [fromView resizableSnapshotViewFromRect:fromSnapshotRect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    
    [backgroundView addSubview:fromSnapshotView];

    // Take a snapshot of the presented view
    CGRect toSnapshotRect = toView.bounds;
    UIView *toSnapshotView = [toView resizableSnapshotViewFromRect:toSnapshotRect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    
    [backgroundView addSubview:toSnapshotView];
    
    toSnapshotView.frame = CGRectOffset(toSnapshotView.frame, 0, -toSnapshotView.frame.size.height);

    [UIView animateWithDuration:self.presentationDuration
                          delay:0.0
         usingSpringWithDamping:0.4f
          initialSpringVelocity:6.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromSnapshotView.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         fromSnapshotView.alpha = 0.5;
                     } completion:^(BOOL finished) {
                     }];
  
    [UIView animateWithDuration:self.presentationDuration
                          delay:0.25
         usingSpringWithDamping:0.4f
          initialSpringVelocity:6.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toSnapshotView.frame = CGRectOffset(toSnapshotView.frame, 0, toSnapshotView.frame.size.height);
                     } completion:^(BOOL finished) {
                         
                         // Remove snapshots and background, invoke context completion
                         [toSnapshotView removeFromSuperview];
                         [fromSnapshotView removeFromSuperview];
                         [backgroundView removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

-(void)executeDropOutAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    // Hold onto views, VCs, context, frames
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [fromViewController view];
    UIView *toView = [toViewController view];
    
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    // Create a transition background view
    UIView *backgroundView = [[UIView alloc] initWithFrame:[transitionContext initialFrameForViewController:fromViewController]];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    [containerView addSubview:backgroundView];
    
    // Take a snapshot of the presenting view
    CGRect fromSnapshotRect = fromView.bounds;
    UIView *fromSnapshotView = [fromView resizableSnapshotViewFromRect:fromSnapshotRect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    
    [backgroundView addSubview:fromSnapshotView];
    
    // Take a snapshot of the presented view
    CGRect toSnapshotRect = toView.bounds;
    UIView *toSnapshotView = [toView resizableSnapshotViewFromRect:toSnapshotRect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    
    [backgroundView addSubview:toSnapshotView];

    toSnapshotView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    toSnapshotView.alpha = 0.5;

    [UIView animateWithDuration:self.dismissalDuration
                          delay:0.0
         usingSpringWithDamping:0.4f
          initialSpringVelocity:6.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromSnapshotView.frame = CGRectOffset(fromSnapshotView.frame, 0, -fromSnapshotView.frame.size.height);
                     } completion:^(BOOL finished) {
                     }];
    
    [UIView animateWithDuration:self.dismissalDuration
                          delay:0.25
         usingSpringWithDamping:0.4f
          initialSpringVelocity:6.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toSnapshotView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         toSnapshotView.alpha = 1.0f;
                   } completion:^(BOOL finished) {
                       
                       // Remove snapshots and background, invoke context completion
                       [toSnapshotView removeFromSuperview];
                       [fromSnapshotView removeFromSuperview];
                       [backgroundView removeFromSuperview];
                       [transitionContext completeTransition:YES];
                     }];
}


@end
