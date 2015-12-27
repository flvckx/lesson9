//
//  SquareGestureRecognizer.m
//  HelpGestureRecognizer
//
//  Created by Anatoliy on 12/27/15.
//  Copyright © 2015 Max Chuquimia. All rights reserved.
//

#import "SquareGestureRecognizer.h"

@implementation SquareGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super initWithTarget:target action:action])) {
        _side = 0.0;
        _sideVariancePercent = 25.0;
        firstTouch = CGPointZero;
        _sideClosureDistanceVariance = 50.0;
    }
    return self;
}

- (void) reset{
    [super reset];
    [points removeAllObjects];
    firstTouch = CGPointZero;
    //_center = CGPointZero;
    _side = 0.0;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    firstTouch = [[touches anyObject] locationInView:self.view];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    CGPoint startPoint = [[touches anyObject] locationInView:self.view];
    [points addObject:NSStringFromCGPoint(startPoint)];
}

static float const ACCEPTED_DEVIATION = 10;

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    CGPoint endPoint = [[touches anyObject] locationInView:self.view];
    [points addObject:NSStringFromCGPoint(endPoint)];
    
    // Didn't finish close enough to starting point
    if (distanceBetweenPointsp(firstTouch, endPoint) > _sideClosureDistanceVariance) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    CGPoint topLeftMost = firstTouch;
    NSUInteger topLeftMostIndex = NSUIntegerMax;
    CGPoint topRightMost = firstTouch;
    NSUInteger topRightMostIndex = NSUIntegerMax;
    CGPoint bottomRightMost = firstTouch;
    NSUInteger  bottomRightMostIndex = NSUIntegerMax;
    CGPoint bottomLeftMost = firstTouch;
    NSUInteger bottomLeftMostIndex = NSUIntegerMax;
    
    int index = 0;
    for (NSString *onePointString in points) {
        CGPoint onePoint = CGPointFromString(onePointString);
        if ((onePoint.x > topRightMost.x) &&
            ((onePoint.y >= firstTouch.y + ACCEPTED_DEVIATION) || (onePoint.y <= firstTouch.y - ACCEPTED_DEVIATION))) {
            topRightMost = onePoint;
            topRightMostIndex = index;
        }
        if ((onePoint.x < topLeftMost.x) &&
            ((onePoint.y >= firstTouch.y + ACCEPTED_DEVIATION) || (onePoint.y <= firstTouch.y - ACCEPTED_DEVIATION))) {
            topLeftMost = onePoint;
            topLeftMostIndex = index;
        }
        if ((onePoint.y < bottomRightMost.y) &&
            ((onePoint.x >= topRightMost.x + ACCEPTED_DEVIATION) || (onePoint.x <= topRightMost.x - ACCEPTED_DEVIATION))) {
            bottomRightMost = onePoint;
            bottomRightMostIndex = index;
        }
        if ((onePoint.y < bottomLeftMost.y) &&
            ((onePoint.x >= firstTouch.x + ACCEPTED_DEVIATION) || (onePoint.x <= firstTouch.x - ACCEPTED_DEVIATION))) {
            bottomLeftMost = onePoint;
            bottomLeftMostIndex = index;
        }
        index++;
    }
    
    // Calculate the radius by looking at the first point and the center
    _side = fabs(distanceBetweenPointsp(topRightMost, firstTouch));
    
    CGFloat minSide = _side - (_side * _sideVariancePercent);
    CGFloat maxSide = _side + (_side * _sideVariancePercent);
    
    if ((fabs(distanceBetweenPointsp(topRightMost, bottomRightMost)) < minSide)
        || (fabs(distanceBetweenPointsp(topRightMost, bottomRightMost)) > maxSide))
        self.state = UIGestureRecognizerStateFailed;
    if ((fabs(distanceBetweenPointsp(bottomLeftMost, bottomRightMost)) < minSide)
        || (fabs(distanceBetweenPointsp(bottomLeftMost, bottomRightMost)) > maxSide))
        self.state = UIGestureRecognizerStateFailed;
    if ((fabs(distanceBetweenPointsp(topLeftMost, bottomLeftMost)) < minSide)
        || (fabs(distanceBetweenPointsp(topLeftMost, bottomLeftMost)) > maxSide))
        self.state = UIGestureRecognizerStateFailed;
    
    self.state = UIGestureRecognizerStateEnded;

}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateFailed;
    [super touchesCancelled:touches withEvent:event];
}

@end


CGFloat distanceBetweenPointsp (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
}