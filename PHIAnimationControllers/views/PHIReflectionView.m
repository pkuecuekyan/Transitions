//
//  PHIReflectionView.m
//  Transitions
//
//  Created by Philipp Kuecuekyan on 7/6/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
//

#import "PHIReflectionView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PHIReflectionView

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

#pragma mark - View lifecycle

- (void)awakeFromNib
{
    [self setUp];
}

#pragma mark - CAReplicatorLayer setup

- (void)setUp {
    // Recreate and configure replicator of base layer
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.instanceCount = 2;
    
    // Move and invert reflection
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    
    // Dim reflection
    layer.instanceAlphaOffset = -0.6;
    
}


@end
