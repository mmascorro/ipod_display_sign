//
//  LBSignAppDelegate.m
//  LBSign
//
//  Created by Miguel Mascorro on 6/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "LBSignAppDelegate.h"


@implementation LBSignAppDelegate

@synthesize window;
@synthesize mainViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

	/*
	UIDevice *device = [UIDevice currentDevice];
	device.batteryMonitoringEnabled = YES;
	
	
	
	if (device.batteryState == UIDeviceBatteryStateCharging || device.batteryState == UIDeviceBatteryStateFull){
		[UIApplication sharedApplication].idleTimerDisabled = YES;
		
		NSLog(@"plugged in, idle disabled");
	} else {
		
		NSLog(@"no power, leave idle");
	}
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryChanged:) name:UIDeviceBatteryStateDidChangeNotification object:device];
	
	NSLog(@"battery state: %@", device.batteryState);
	*/
	
	//[UIApplication sharedApplication].idleTimerDisabled = YES;

	
	
		
	[window addSubview:mainViewController.view];
	
	[window makeKeyAndVisible];
	
    // Add the view controller's view to the window and display.
    //[window addSubview:viewController.view];
	
	
	

	//[ps release];
	
	return YES;
	
}



/*
- (void)batteryChanged:(NSNotification *)notification {
	UIDevice *device = [notification object];
	
	
	if (device.batteryState == UIDeviceBatteryStateCharging || device.batteryState == UIDeviceBatteryStateFull){
		[UIApplication sharedApplication].idleTimerDisabled = YES;
		
		NSLog(@"plugged in, idle disabled");
	} else {
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		NSLog(@"no power, leave idle");
	}
	
	
	NSLog(@"battery: %@", device.batteryState);
	
	
}
*/

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	NSLog(@"will resign active");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	NSLog(@"did enter background");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	NSLog(@"will enter foreground");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	
	//[UIApplication sharedApplication].idleTimerDisabled = YES;

	
	NSLog(@"didbecomeactive");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	NSLog(@"will terminate");
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
	NSLog(@"did get memory warning");
	
}


- (void)dealloc {
	[mainViewController release];
    [window release];
    [super dealloc];
}


@end
