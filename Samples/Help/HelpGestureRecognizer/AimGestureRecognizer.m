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
    
    if (checkThePoint)
    {
        [super touchesEnded:touches withEvent:event];
        [self reset];
    }
    else
    {
        [super touchesEnded:touches withEvent:event];
        
        checkThePoint = TRUE;
        
        //cancel the drawing if the user takes too long to dot the ?
        [self performSelector:@selector(reset) withObject:[self superclass] afterDelay:1.25f];
    }
    
}


@end
