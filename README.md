#Transitions
Sample project and collection of animation controllers to illustrate and animate transitions between UIViewControllers (modally and those embedded in UINavigationControllers or UITabBarControllers). Shows and expands the functionality of the UIViewControllerContextTransitioning protocol.

## How to use the sample

The project can run on iPhones or be executed in the simulator (requires iOS 7 or above). Just open the project in Xcode 5 (and above).

## Usage

To use in your own projects, just drag the files in the PHIAnimationControllers folder into your own project and import the header files. Then, allocate an instance 

```objective-c
PHICubeAnimationController *cubeAnimationController = [[PHICubeAnimationController alloc] init];
```

and return it in the corresponding protocol methods

```objective-c
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
	...
	if (operation == UINavigationControllerOperationPush) {
        cubeAnimationController.isPresenting = YES;
    } else {
        cubeAnimationController.isPresenting = NO;
    }

	return cubeAnimationController;
}
```

## Types of animations

+ Cube (PHICubeAnimationController)
+ Doorway (PHIDoorwayAnimationController)
+ Drop-in (PHIDropAnimationController)

