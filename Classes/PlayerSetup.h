//
//  PlayerSetup.h
//  LBSign
//
//  Created by Miguel Mascorro on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBSignViewController.h"

@interface PlayerSetup : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField *playerUrl;
	IBOutlet UIButton *playButton;
	LBSignViewController *lbvc;
}

@property (nonatomic, retain) UITextField *playerUrl;
@property (nonatomic, retain) UIButton *playButton;
@property (nonatomic, retain) LBSignViewController *lbvc;


- (IBAction) saveUrl:(id)sender;
- (IBAction) startPlayer:(id)sender;
-(void) showPlayer;
@end
