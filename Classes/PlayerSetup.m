//
//  PlayerSetup.m
//  LBSign
//
//  Created by Miguel Mascorro on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerSetup.h"
#import "LBSignAppDelegate.h"


@implementation PlayerSetup


@synthesize playerUrl;
@synthesize playButton;
@synthesize lbvc;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/**/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	
	if ( [[defaults stringForKey:@"playlist_preference"] length] == 0) {
		[defaults setObject:@"http://192.168.1.10/sign/playlist" forKey:@"playlist_preference"];
		
		
		
	} 
	
	
	[UIApplication sharedApplication].idleTimerDisabled = NO;
	
	
	playerUrl.text = [defaults stringForKey:@"playlist_preference"];
	
	playerUrl.delegate = self;
	
	//[self showPlayer];
	
}
- (IBAction) startPlayer:(id)sender {
	
	NSLog(@"start it up");
	
	[self showPlayer];	
}

- (IBAction) saveUrl:(id)sender {
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	
	[defaults setObject:playerUrl.text forKey:@"playlist_preference"];

	
}

-(void) showPlayer {
	
	UITextField *tf = self.playerUrl;
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:tf.text forKey:@"playlist_preference"];
	
	lbvc = [[LBSignViewController alloc] initWithNibName:@"LBSignViewController" bundle:nil];
	
	CGRect bs = self.view.bounds;
	lbvc.view.frame = bs;
	
	//theMovie.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[self.view addSubview:lbvc.view];
	
	
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}
/**/
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[playerUrl release];
	[playButton release];
	
    [super dealloc];
}


@end
