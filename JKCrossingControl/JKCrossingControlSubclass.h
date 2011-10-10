//
//  JKCrossingControlSubclass.h
//  SwitchedDemo
//
//  Created by Justin Kaufman on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// These extensions are intended only for subclasses of JKCrossingControl and should not be called directly.
// Overridden methods must begin by calling |super|.

@interface JKCrossingControl ()

// Re-declaration of property surrounding _crossingRecognizer.
@property (nonatomic, retain) JKCrossingGestureRecognizer *crossingRecognizer;

// Subclasses may override |-configureControl| to perform their own customizations of the recognizer after it has been added.
// All readwrite properties of JKCrossingGestureRecognizer may be safely modified with the exception of crossingRegion. Subclasses
// that wish to grow or shrink the recognition region should set |crossingRegionInset|.
- (void)configureControl;

// Subclasses may override |-crossingGestureChanged:| to act on the gesture state to update their display.
// Several readonly JKCrossingGestureRecognizer properties are of interest to subclasses:
//   state (began)
//     The state of the gesture recognizer. See UIGestureRecognizer docs for details.
//     Subclasses may ignore states other than UIGestureRecognizerStateEnded.
//   location
//     First available: began
//     Description: The location of the candidate touch within this control's frame.
//     Example use: A switch may use location to update the position of its nub during the drag.
//   velocity 
//     First available: changed
//     Description: Instantaneous gesture velocity in px/s, calculated using the last two touch events.
//     Example use: A switch may use this speed, or several readings, to animate the dragging or flicking of its nub.
//   direction
//     First available: ended
//     Description: The gesture's observed heading (left/up/right/down).
//     Example use: A switch supports left and right gestures, but should only switch OFF if swiped left.
- (void)crossingGestureChanged:(JKCrossingGestureRecognizer *)recognizer;

@end