//
//  AimGestureRecognizer.m
//  HelpGestureRecognizer
//
//  Created by Anatoliy on 12/26/15.
//  Copyright © 2015 Max Chuquimia. All rights reserved.
//

#import "AimGestureRecognizer.h"

@implementation AimGestureRecognizer

-(void) reset {
    [super reset];
    checkThePoint = FALSE;
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (super.self.state != UIGestureRecognizerStateFailed) {
        checkThePoint = TRUE;
        //cancel the drawing if the user takes too long to dot the o
        [self performSelector:@selector(reset) withObject:[self superclass] afterDelay:1.25f];
    } else {
        [self reset];
        self.state = UIGestureRecognizerStateFailed;
    }    
}


@end
