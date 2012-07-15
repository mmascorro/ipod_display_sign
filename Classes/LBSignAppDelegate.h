//
//  LBSignAppDelegate.h
//  LBSign
//
//  Created by Miguel Mascorro on 6/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBSignAppDelegate;

@interface LBSignAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UIViewController *mainViewController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *mainViewController;




@end

