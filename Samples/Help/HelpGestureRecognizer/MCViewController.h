//
//  MCViewController.h
//  HelpGestureRecognizer
//
//  Created by Max Chuquimia on 22/12/13.
//

#import <UIKit/UIKit.h>
#import "MCHelpGestureRecognizer.h"
#import "CircleGestureRecognizer.h"
#import "AimGestureRecognizer.h"
#import "SquareGestureRecognizer.h"

@interface MCViewController : UIViewController <UIGestureRecognizerDelegate>
{
    MCHelpGestureRecognizer *helpRecognizer;
    IBOutlet UILabel *detectionLabel;
    
    CircleGestureRecognizer *circleRecognizer;
    AimGestureRecognizer *aimRecognizer;
    SquareGestureRecognizer *squareRecognizer;
}
@end
