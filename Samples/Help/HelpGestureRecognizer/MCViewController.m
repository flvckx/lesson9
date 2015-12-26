//
//  MCViewController.m
//  HelpGestureRecognizer
//
//  Created by Max Chuquimia on 22/12/13.
//

#import "MCViewController.h"

@interface MCViewController ()

@end

@implementation MCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	helpRecognizer = [[MCHelpGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(showHelp)];
    [helpRecognizer setDelegate:self];
    [self.view addGestureRecognizer:helpRecognizer];
    
    [detectionLabel setAlpha:0.0f];
    
    circleRecognizer = [[CircleGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(showO)];
    [circleRecognizer setDelegate:self];
    [self.view addGestureRecognizer:circleRecognizer];
}

-(void)showHelp
{
    UIColor *c = [UIColor colorWithRed:((float)(arc4random() % 255))/255.0f green:((float)(arc4random() % 255))/255.0f blue:((float)(arc4random() % 255))/255.0f alpha:1.0f];
    [self.view setBackgroundColor:c];
    
    NSLog(@"HELP ME!");
    
    [detectionLabel setAlpha:1.0f];
    
    [UIView animateWithDuration:1.0f animations:^{[detectionLabel setAlpha:0.0f];}];
}

- (void) showO {
    UIColor *c = [UIColor colorWithRed:((float)(arc4random() % 255))/255.0f green:((float)(arc4random() % 255))/255.0f blue:((float)(arc4random() % 255))/255.0f alpha:1.0f];
    [self.view setBackgroundColor:c];
    
    NSLog(@"o!");
    
    detectionLabel.text = @"Circle's detected";
    
    [detectionLabel setAlpha:1.0f];
    
    [UIView animateWithDuration:1.0f animations:^{[detectionLabel setAlpha:0.0f];}];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
