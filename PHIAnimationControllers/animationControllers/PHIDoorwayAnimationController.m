//
//  PHIDoorwayAnimationController.m
//  Transitions
//
//  Created by Philipp Kuecuekyan on 7/8/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
//

#import "PHIDoorwayAnimationController.h"
#import "PHIReflectionView.h"

static const float kDoorwayZoomScale = 0.1;

@implementation PHIDoorwayAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    if (self.isPresenting) {
        [self executeDoorwayInAnimation:transitionContext];
    } else {
        [self executeDoorwayOutAnimation:transitionContext];
    }
}


- (void)executeDoorwayInAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // Hold onto views, VCs, context, frames
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    UIView *containerView = transitionContext.containerView;
    
    [containerView addSubview:toView];
    
    // Create a transition background view
    UIView *backgroundView = [[UIView alloc] initWithFrame:[transitionContext initialFrameForViewController:fromViewController]];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    [containerView addSubview:backgroundView];
    
    // Take a snapshot of the presenting view: left
    CGRect fromLeftSnapshotRect = CGRectMake(0.0, 0.0, fromView.frame.size.width / 2, fromView.frame.size.height);
    UIView *fromLeftSnapshotView = [fromView resizableSnapshotViewFromRect:fromLeftSnapshotRect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    fromLeftSnapshotView.frame = fromLeftSnapshotRect;
    
    [backgroundView addSubview:fromLeftSnapshotView];

    // Take a snapshot of the presenting view: right
    CGRect fromRightSnapshotRect = CGRectMake(fromView.frame.size.width / 2, 0.0, fromView.frame.size.width / 2, fromView.frame.size.height);
    UIView *fromRightSnapshotView = [fromView resizableSnapshotViewFromRect:fromRightSnapshotRect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    fromRightSnapshotView.frame = fromRightSnapshotRect;
    
    [backgroundView addSubview:fromRightSnapshotView];

    // Take a snapshot of the presented view
    CGRect toSnapshotRect = containerView.frame;
    PHIReflectionView *toSnapshotView = [[PHIReflectionView alloc] initWithFrame:toSnapshotRect];
    [toSnapshotView addSubview:[toView resizableSnapshotViewFromRect:toSnapshotRect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero]];
    CATransform3D scale = CATransform3DIdentity;
    toSnapshotView.layer.transform = CATransform3DScale(scale, kDoorwayZoomScale, kDoorwayZoomScale, 1);
    toSnapshotView.alpha = 0.1;
    
    [backgroundView addSubview:toSnapshotView];
    
    // Animate the left and right side of presenting view, zoom in presented view
    [UIView animateWithDuration:self.presentationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toSnapshotView.layer.transform = CATransform3DScale(scale, 1.0, 1.0, 1);
                         toSnapshotView.alpha = 1.0;
                         fromLeftSnapshotView.frame = CGRectOffset(fromLeftSnapshotView.frame, - fromLeftSnapshotView.frame.size.width, 0);
                         fromRightSnapshotView.frame = CGRectOffset(fromRightSnapshotView.frame, fromRightSnapshotView.frame.size.width, 0);
                     } completion:^(BOOL finished) {
                         
                         // Remove snapshots and background, invoke context completion
                         [fromLeftSnapshotView removeFromSuperview];
                         [fromRightSnapshotView removeFromSuperview];
                         [backgroundView removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
}


- (void)executeDoorwayOutAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // Hold onto views, VCs, context, frames
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    UIView *containerView = transitionContext.containerView;
    
    [containerView addSubview:toView];
    
    // Create a transition background view
    UIView *backgroundView = [[UIView alloc] initWithFrame:[transitionContext initialFrameForViewController:fromViewController]];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    [containerView addSubview:backgroundView];
    
    // Take a snapshot of the presented view: left
    CGRect toLeftSnapshotRect = CGRectMake(0.0, 0.0, toView.frame.size.width / 2, toView.frame.size.height);
    UIView *toLeftSnapshotView = [toViewController.view resizableSnapshotViewFromRect:toLeftSnapshotRect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    toLeftSnapshotView.frame = toLeftSnapshotRect;
    toLeftSnapshotView.frame = CGRectOffset(toLeftSnapshotView.frame, - toLeftSnapshotView.frame.size.width, 0);
    
    [backgroundView addSubview:toLeftSnapshotView];
    
    // Take a snapshot of the presented view: right
    CGRect toRightSnapshotRect = CGRectMake(toView.frame.size.width / 2, 0.0, toView.frame.size.width / 2, fromView.frame.size.height);
    UIView *toRightSnapshotView = [toViewController.view resizableSnapshotViewFromRect:toRightSnapshotRect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    toRightSnapshotView.frame = toRightSnapshotRect;
    toRightSnapshotView.frame = CGRectOffset(toRightSnapshotView.frame, toRightSnapshotView.frame.size.width, 0);
    
    [backgroundView addSubview:toRightSnapshotView];
    
    // Take a snapshot of the presenting view
    CGRect fromSnapshotRect = containerView.frame;
    PHIReflectionView *fromSnapshotView = [[PHIReflectionView alloc] initWithFrame:fromSnapshotRect];
    [fromSnapshotView addSubview:[fromView resizableSnapshotViewFromRect:fromSnapshotRect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero]];
    
    [backgroundView addSubview:fromSnapshotView];
    
    // Animate the left and right side of presenting view, zoom in presented view
    [UIView animateWithDuration:self.dismissalDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromSnapshotView.transform = CGAffineTransformMakeScale(kDoorwayZoomScale, kDoorwayZoomScale);
                         fromSnapshotView.alpha = 0.0;
                         toLeftSnapshotView.frame = CGRectOffset(toLeftSnapshotView.frame, toLeftSnapshotView.frame.size.width, 0);
                         toRightSnapshotView.frame = CGRectOffset(toRightSnapshotView.frame, - toRightSnapshotView.frame.size.width, 0);

                     } completion:^(BOOL finished) {
                         
                         // Remove snapshots and background, invoke context completion
                         [toLeftSnapshotView removeFromSuperview];
                         [toRightSnapshotView removeFromSuperview];
                         [backgroundView removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
}


@end
