//
//  CircleGestureRecognizer.h
//  HelpGestureRecognizer
//
//  Created by Anatoliy on 12/24/15.
//  Copyright © 2015 Max Chuquimia. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>


CGFloat distanceBetweenPoints (CGPoint first, CGPoint second);
CGFloat angleBetweenPoints(CGPoint first, CGPoint second);
CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint lin2End);

@interface CircleGestureRecognizer : UIGestureRecognizer
{
    NSMutableArray *points_;
    CGPoint firstTouch_;
    NSTimeInterval firstTouchTime_;
}

@property CGFloat circleClosureAngleVariance;
@property CGFloat circleClosureDistanceVariance;
@property CGFloat maximumCircleTime;
@property CGFloat radiusVariancePercent;
@property NSInteger overlapTolerance;

@property (readonly) CGPoint center;
@property (readonly) CGFloat radius;
@property (readonly) NSArray *points;

@end
