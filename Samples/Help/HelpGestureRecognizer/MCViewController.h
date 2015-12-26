//
//  MCViewController.h
//  HelpGestureRecognizer
//
//  Created by Max Chuquimia on 22/12/13.
//

#import <UIKit/UIKit.h>
#import "MCHelpGestureRecognizer.h"
#import "CircleGestureRecognizer.h"

@interface MCViewController : UIViewController <UIGestureRecognizerDelegate>
{
    MCHelpGestureRecognizer *helpRecognizer;
    IBOutlet UILabel *detectionLabel;
    
    CircleGestureRecognizer *circleRecognizer;
}
@end
