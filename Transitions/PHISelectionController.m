//
//  PHISelectionController.m
//  Transitions
//
//  Created by Philipp Kuecuekyan on 7/8/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
//

#import "PHISelectionController.h"
#import "PHIAnimationController.h"

#import "PHICubeAnimationController.h"
#import "PHIDoorwayAnimationController.h"
#import "PHIDropAnimationController.h"

@interface PHISelectionController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cubeButton;
@property (weak, nonatomic) IBOutlet UIButton *doorButton;
@property (weak, nonatomic) IBOutlet UIButton *swapButton;

@property (strong, nonatomic) PHIAnimationController *animationController;
@end

@implementation PHISelectionController

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIButton *buttonPressed = (UIButton*)sender;
    switch (buttonPressed.tag) {
        case 0:
            self.animationController = [[PHICubeAnimationController alloc] init];
            break;
        case 1:
            self.animationController = [[PHIDoorwayAnimationController alloc] init];
            break;
        default:
            self.animationController = [[PHIDropAnimationController alloc] init];
            break;
    }
    
    self.navigationController.delegate = self;
    UIViewController *toVC = segue.destinationViewController;
    
    toVC.transitioningDelegate = self;
    
    [super prepareForSegue:segue sender:sender];
}

#pragma mark - UIViewControllerTransitioningDelegate

/* UINavigationController transition */

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        self.animationController.isPresenting = YES;
    } else {
        self.animationController.isPresenting = NO;
    }
    return self.animationController;
}

/* UIViewController model and custom transitions */


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    self.animationController.isPresenting = YES;
    return self.animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animationController.isPresenting = NO;
    return self.animationController;
}

@end
