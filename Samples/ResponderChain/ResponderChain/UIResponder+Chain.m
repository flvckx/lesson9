//
//  UIResponder+Chain.m
//  ResponderChain
//
//  Created by Anton Lookin on 12/21/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "UIResponder+Chain.h"

@implementation UIResponder (Chain)

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	NSLog(@"%@", self);
	[self.nextResponder touchesBegan:touches withEvent:event];
}


-(BOOL) canBecomeFirstResponder {
	return NO;
}

@end
