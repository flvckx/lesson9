//
//  SquareGestureRecognizer.h
//  HelpGestureRecognizer
//
//  Created by Anatoliy on 12/27/15.
//  Copyright © 2015 Max Chuquimia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

CGFloat distanceBetweenPointsp (CGPoint first, CGPoint second);

@interface SquareGestureRecognizer : UIGestureRecognizer
{
    NSMutableArray *points;
    CGPoint firstTouch;
}

@property (readonly) CGFloat side;
@property (readonly) CGFloat sideVariancePercent;
@property CGFloat sideClosureDistanceVariance;

@end
