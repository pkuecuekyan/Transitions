//
//  PHICubeAnimationController.m
//  Transitions
//
//  Created by Philipp Kuecuekyan on 7/8/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
//

#import "PHICubeAnimationController.h"

@implementation PHICubeAnimationController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.presentationDuration = self.dismissalDuration = 0.6f;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    [super animateTransition:transitionContext];
    if (self.isPresenting){
        [self executeCubeAnimationWithContext:transitionContext direction:turnRight];
    }
    else{
        [self executeCubeAnimationWithContext:transitionContext direction:turnLeft];
    }
    
}

- (void)executeCubeAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext direction:(PHICubeDirection)direction {
    
    // Hold onto views, VCs, context, frames
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [fromViewController view];
    UIView *toView = [toViewController view];
    toView.frame = [fromViewController view].frame;

    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    // Create a transition background view
    UIView *backgroundView = [[UIView alloc] initWithFrame:[transitionContext initialFrameForViewController:fromViewController]];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    [containerView addSubview:backgroundView];
    
    // Take a snapshot of the presenting view
    CGRect fromSnapshotRect = fromView.bounds;
    UIView *fromSnapshotView = [fromView resizableSnapshotViewFromRect:fromSnapshotRect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    fromSnapshotView.layer.anchorPointZ = -fromSnapshotView.frame.size.width / 2;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 1000;
    transform = CATransform3DTranslate(transform, 0, 0, fromSnapshotView.layer.anchorPointZ);
    fromSnapshotView.layer.transform = transform;
    fromSnapshotView.layer.borderColor = [UIColor blackColor].CGColor;
    fromSnapshotView.layer.borderWidth = 2.0f;
    
    [backgroundView addSubview:fromSnapshotView];
    
    // Take a snapshot of the presented view
    CGRect toSnapshotRect = toView.bounds;
    UIView *toSnapshotView = [toView resizableSnapshotViewFromRect:toSnapshotRect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    toSnapshotView.layer.anchorPointZ = -toSnapshotView.frame.size.width / 2;
    transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 1000;
    transform = CATransform3DTranslate(transform, 0, 0, toSnapshotView.layer.anchorPointZ);
    toSnapshotView.layer.transform = transform;
    
    [backgroundView insertSubview:toSnapshotView belowSubview:fromSnapshotView];
    
    // Move the presented view off screen
    if (direction == turnLeft) {
        toSnapshotView.layer.transform = CATransform3DRotate(toSnapshotView.layer.transform, -M_PI_2, 0, 1, 0);
    } else {
        toSnapshotView.layer.transform = CATransform3DRotate(toSnapshotView.layer.transform, M_PI_2, 0, 1, 0);
    }
    
    NSLog(@"from %@ and to %@", NSStringFromCGRect(fromSnapshotRect), NSStringFromCGRect(toSnapshotRect));
    // Animated in the presenting and presented view simultaneously
    [UIView animateWithDuration:self.presentationDuration animations:^{
        
        if (direction == turnLeft) {
            toSnapshotView.layer.transform = CATransform3DRotate(toSnapshotView.layer.transform, M_PI_2, 0, 1, 0);
            fromSnapshotView.layer.transform = CATransform3DRotate(fromSnapshotView.layer.transform, M_PI_2, 0, 1, 0);
        } else {
            toSnapshotView.layer.transform = CATransform3DRotate(toSnapshotView.layer.transform, -M_PI_2, 0, 1, 0);
            fromSnapshotView.layer.transform = CATransform3DRotate(fromSnapshotView.layer.transform, -M_PI_2, 0, 1, 0);
                    }
    } completion:^(BOOL finished){
        
        // Remove snapshots and background, invoke context completion
        [fromSnapshotView removeFromSuperview];
        [toSnapshotView removeFromSuperview];
        [backgroundView removeFromSuperview];
        [transitionContext completeTransition:YES];
        
    }];

}


@end
