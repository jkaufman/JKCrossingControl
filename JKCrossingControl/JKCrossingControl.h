//
//  JKCrossingControl.h
//  JKCrossingControl
//
//  Created by Justin Kaufman on 6/25/11.
//  Copyright 2011 Justin Kaufman. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    JKControlEventCrossUp           = 1 << 24,
    JKControlEventCrossDown         = 1 << 25,
    JKControlEventCrossLeft         = 1 << 26,
    JKControlEventCrossRight        = 1 << 27,
    JKControlEventCrossVertical     = JKControlEventCrossUp | JKControlEventCrossDown,
    JKControlEventCrossHorziontal   = JKControlEventCrossLeft| JKControlEventCrossRight,
    JKControlAllCrossingEvents      = UIControlEventApplicationReserved,
};
typedef NSUInteger JKControlEvent;

@class JKCrossingGestureRecognizer;

@interface JKCrossingControl : UIControl {

@private
    JKCrossingGestureRecognizer *_crossingRecognizer;
    CGSize _crossingRegionInset;

}

@end