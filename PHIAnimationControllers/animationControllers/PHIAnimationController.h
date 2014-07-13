//
//  PHIAnimationController.h
//  Transitions
//
//  Created by Philipp Kuecuekyan on 7/9/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
//

@interface PHIAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, assign) NSTimeInterval presentationDuration;
@property (nonatomic, assign) NSTimeInterval dismissalDuration;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
