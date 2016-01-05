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
    
    circleRecognizer = [[CircleGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(showO)];
    [circleRecognizer setDelegate:self];
    [self.view addGestureRecognizer:circleRecognizer];
    
//    aimRecognizer = [[AimGestureRecognizer alloc] initWithTarget:self
//                                                          action:@selector(showAim)];
//    [aimRecognizer setDelegate:self];
//    [self.view addGestureRecognizer:aimRecognizer];
    
    squareRecognizer = [[SquareGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(showSquare)];
    [squareRecognizer setDelegate:self];
    [self.view addGestureRecognizer:squareRecognizer];
    
    [detectionLabel setAlpha:0.0f];
}

-(void)showHelp
{
    UIColor *c = [UIColor colorWithRed:((float)(arc4random() % 255))/255.0f green:((float)(arc4random() % 255))/255.0f blue:((float)(arc4random() % 255))/255.0f alpha:1.0f];
    [self.view setBackgroundColor:c];
    
    NSLog(@"HELP ME!");
    
    detectionLabel.text = @"Question mark's detected";
    
    [detectionLabel setAlpha:1.0f];
    
    [UIView animateWithDuration:1.0f animations:^{[detectionLabel setAlpha:0.0f];}];
}

- (void)showO {
    UIColor *c = [UIColor colorWithRed:((float)(arc4random() % 255))/255.0f green:((float)(arc4random() % 255))/255.0f blue:((float)(arc4random() % 255))/255.0f alpha:1.0f];
    [self.view setBackgroundColor:c];
    
    NSLog(@"o!");
    
    detectionLabel.text = @"Circle's detected";
    
    [detectionLabel setAlpha:1.0f];
    
    [UIView animateWithDuration:1.0f animations:^{[detectionLabel setAlpha:0.0f];}];
    
}

- (void)showAim {
    UIColor *c = [UIColor colorWithRed:((float)(arc4random() % 255))/255.0f green:((float)(arc4random() % 255))/255.0f blue:((float)(arc4random() % 255))/255.0f alpha:1.0f];
    [self.view setBackgroundColor:c];
    
    NSLog(@"Look over there!");
    
    detectionLabel.text = @"Aim's detected";
    
    [detectionLabel setAlpha:1.0f];
    
    [UIView animateWithDuration:1.0f animations:^{[detectionLabel setAlpha:0.0f];}];
}

- (void)showSquare {
    UIColor *c = [UIColor colorWithRed:((float)(arc4random() % 255))/255.0f green:((float)(arc4random() % 255))/255.0f blue:((float)(arc4random() % 255))/255.0f alpha:1.0f];
    [self.view setBackgroundColor:c];
    
    NSLog(@">[_]<!");
    
    detectionLabel.text = @"Square's detected";
    
    [detectionLabel setAlpha:1.0f];
    
    [UIView animateWithDuration:1.0f animations:^{[detectionLabel setAlpha:0.0f];}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
