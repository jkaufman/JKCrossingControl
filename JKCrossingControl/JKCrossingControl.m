//
//  JKCrossingControl.m
//  JKCrossingControl
//
//  Created by Justin Kaufman on 6/25/11.
//  Copyright 2011 Justin Kaufman. All rights reserved.
//

#import "JKCrossingControl.h"
#import "JKCrossingGestureRecognizer.h"
#import "UIView+JKCrossingGestureAdditions.h"

@interface JKCrossingControl ()

@property (nonatomic, retain) JKCrossingGestureRecognizer *crossingRecognizer;
@property (nonatomic, assign) CGSize crossingRegionInset;

- (void)configureControl;
- (void)crossingGestureChanged:(JKCrossingGestureRecognizer *)recognizer;

@end

@implementation JKCrossingControl

@synthesize crossingRecognizer = _crossingRecognizer;
@synthesize crossingRegionInset = _crossingRegionInset;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self configureControl];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self configureControl];
    }
    return self;
}

- (void)configureControl {
    self.crossingRecognizer = [[[JKCrossingGestureRecognizer alloc] initWithTarget:self action:@selector(crossingGestureChanged:)] autorelease];
    self.crossingRecognizer.recognizedDirections = JKCrossingGestureRecognizerDirectionUp | JKCrossingGestureRecognizerDirectionDown; // Default to vertical gestures.
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    // Remove gesture recognizer from current view.
    [[self topmostContainingView] removeGestureRecognizer:self.crossingRecognizer];
}
- (void)didMoveToWindow {    
    // Reparent gesture recognizer.
    UIView *topmostView = [self topmostContainingView];
    [topmostView addGestureRecognizer:self.crossingRecognizer];
    self.crossingRecognizer.crossingRegion = [topmostView convertRect:CGRectInset(self.frame, self.crossingRegionInset.width, self.crossingRegionInset.height) fromView:self.superview];
}

- (void)crossingGestureChanged:(JKCrossingGestureRecognizer *)recognizer {
    // Send actions associated with the successful gesture once it has ended.
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        switch (recognizer.direction) {
            case JKCrossingGestureRecognizerDirectionLeft:
                [self sendActionsForControlEvents:JKControlEventCrossLeft];
                break;
            case JKCrossingGestureRecognizerDirectionRight:
                [self sendActionsForControlEvents:JKControlEventCrossRight];
                break;
            case JKCrossingGestureRecognizerDirectionUp:
                [self sendActionsForControlEvents:JKControlEventCrossUp];
                break;
            case JKCrossingGestureRecognizerDirectionDown:
                [self sendActionsForControlEvents:JKControlEventCrossDown];
                break;
        }
    }
}

- (void)dealloc {
    [_crossingRecognizer release];
    [super dealloc];
}

@end
