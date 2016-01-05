//
//  CircleGestureRecognizer.m
//  HelpGestureRecognizer
//
//  Created by Anatoliy on 12/24/15.
//  Copyright © 2015 Max Chuquimia. All rights reserved.
//

#import "CircleGestureRecognizer.h"

@implementation CircleGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super initWithTarget:target action:action])) {
        _circleClosureAngleVariance = 45.0;
        _circleClosureDistanceVariance = 50.0;
        _maximumCircleTime = 20.0;
        _radiusVariancePercent = 25.0;
        _overlapTolerance = 3;
        points_ = [[NSMutableArray alloc] init];
        firstTouch_ = CGPointZero;
        firstTouchTime_ = 0.0;
        _center = CGPointZero;
        _radius = 0.0; 
    }
    return self;
}

- (void) reset{
    [super reset];
    [points_ removeAllObjects];
    firstTouch_ = CGPointZero;
    firstTouchTime_ = 0.0;
    _center = CGPointZero;
    _radius = 0.0;
    
    
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    firstTouch_ = [[touches anyObject] locationInView:self.view];
    firstTouchTime_ = [NSDate timeIntervalSinceReferenceDate];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    CGPoint startPoint = [[touches anyObject] locationInView:self.view];
    [points_ addObject:NSStringFromCGPoint(startPoint)];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    CGPoint endPoint = [[touches anyObject] locationInView:self.view];
    [points_ addObject:NSStringFromCGPoint(endPoint)];
    
    // Didn't finish close enough to starting point
    if (distanceBetweenPoints(firstTouch_, endPoint) > _circleClosureDistanceVariance) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    // Took too long to draw
    if ([NSDate timeIntervalSinceReferenceDate] - firstTouchTime_ > _maximumCircleTime) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    // Not enough points
    if ([points_ count] < 7) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    CGPoint leftMost = firstTouch_;
    NSUInteger leftMostIndex = NSUIntegerMax;
    CGPoint topMost = firstTouch_;
    NSUInteger topMostIndex = NSUIntegerMax;
    CGPoint rightMost = firstTouch_;
    NSUInteger  rightMostIndex = NSUIntegerMax;
    CGPoint bottomMost = firstTouch_;
    NSUInteger bottomMostIndex = NSUIntegerMax;
    
    int index = 0;
    for (NSString *onePointString in points_) {
        CGPoint onePoint = CGPointFromString(onePointString);
        if (onePoint.x > rightMost.x) {
            rightMost = onePoint;
            rightMostIndex = index;
        }
        if (onePoint.x < leftMost.x) {
            leftMost = onePoint;
            leftMostIndex = index;
        }
        if (onePoint.y > topMost.y) {
            topMost = onePoint;
            topMostIndex = index;
        }
        if (onePoint.y < bottomMost.y) {
            bottomMost = onePoint;
            bottomMostIndex = index;
        }
        index++;
    }
    
    // If startPoint is one of the extreme points, take set it
    if (rightMostIndex == NSUIntegerMax) {
        rightMost = firstTouch_;
    }
    if (leftMostIndex == NSUIntegerMax) {
        leftMost = firstTouch_;
    }
    if (topMostIndex == NSUIntegerMax ){
        topMost = firstTouch_;
    }
    if (bottomMostIndex == NSUIntegerMax) {
        bottomMost = firstTouch_;
    }
    
    // Figure out the approx middle of the circle
    _center = CGPointMake(leftMost.x + (rightMost.x - leftMost.x) / 2.0, bottomMost.y + (topMost.y - bottomMost.y) / 2.0);

    // This check is probably not necessary
    // Make sure they closed the circle - the startPoint and endPoint should be within a few degrees of each other.
//        CGFloat angle = angleBetweenLines(firstTouch, center, endPoint, center);
//    
//        if (fabs(angle) > kCircleClosureAngleVariance ) {
//            label.text = [NSString stringWithFormat:@"Didn't close circle, angle (%f) too large!", fabs(angle)];
//            [self performSelector:@selector(eraseText) withObject:nil afterDelay:2.0];
//            return;
//        }
    
    // Calculate the radius by looking at the first point and the center
    _radius = fabs(distanceBetweenPoints(_center, firstTouch_));
    
    CGFloat currentAngle = 0.0;
    BOOL hasSwitched = NO;
    
    // Start Circle Check=========================================================
    // Make sure all points on circle are within a certain percentage of the radius from the center
    // Make sure that the angle switches direction only once. As we go around the circle,
    //    the angle between the line from the start point to the end point and the line from  the
    //    current point and the end point should go from 0 up to about 180.0, and then come
    //    back down to 0 (the function returns the smaller of the angles formed by the lines, so
    //    180° is the highest it will return, 0 the lowest. If it switches direction more than once,
    //    then it's not a circle
    CGFloat minRadius = _radius - (_radius * _radiusVariancePercent / 100);
    CGFloat maxRadius = _radius + (_radius * _radiusVariancePercent / 100);
    
    index = 0;
    for (NSString *onePointString in points_) {
        CGPoint onePoint = CGPointFromString(onePointString);
        CGFloat distanceFromRadius = fabs(distanceBetweenPoints(_center, onePoint));
        
        if (distanceFromRadius < minRadius || distanceFromRadius > maxRadius) {
            self.state = UIGestureRecognizerStateFailed;
            return;
        }
        
        CGFloat pointAngle = angleBetweenLines(firstTouch_, _center, onePoint, _center);
        
        if ((pointAngle > currentAngle && hasSwitched) && (index < [points_ count] - _overlapTolerance)) {
            self.state = UIGestureRecognizerStateFailed;
            return;
        }
        
        if (pointAngle < currentAngle) {
            if (!hasSwitched)
                hasSwitched = YES;
        }
        
        currentAngle = pointAngle;
        index++;
    }
    // End Circle Check=========================================================
    
    self.state = UIGestureRecognizerStateEnded;
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateFailed;
    [super touchesCancelled:touches withEvent:event];
}


@end

#define degreesToRadian(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (180.0 * x / M_PI)

CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
}

CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(height/width);
    return radiansToDegrees(rads);
    //degs = degrees(atan((top - bottom)/(right - left)))
}

CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
    
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    return radiansToDegrees(rads);
}
