//
//  PlayListVideoItem.m
//  LBSign
//
//  Created by Miguel Mascorro on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayListVideoItem.h"
#import "LBSignViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMoviePlayerController.h>

@implementation PlayListVideoItem


//@synthesize theMovie;


-(void) playContent:(LBSignViewController *)lbvc{
	
	
	MPMoviePlayerViewController *theMovie = lbvc.theMovie;
	
	
	NSURL *murl = [NSURL URLWithString:self.itemSrc];
	
	
	
	theMovie.moviePlayer.contentURL = murl;
	
	
    theMovie.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    theMovie.moviePlayer.controlStyle = MPMovieControlStyleNone;
	
	CGRect bs = lbvc.view.bounds;
	theMovie.view.frame = bs;
	
	theMovie.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	
	
	[lbvc.view addSubview:theMovie.view];
	
	/*
	CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	theAnimation.duration=.5;
	theAnimation.fromValue=[NSNumber numberWithFloat:0.0];
	theAnimation.toValue=[NSNumber numberWithFloat:01.0];
	[theMovie.view.layer addAnimation:theAnimation forKey:@"animateOpacity"];
	
	*/
	
	// Register for the playback finished notification
	
	[[NSNotificationCenter defaultCenter]
	 addObserver: lbvc
	 selector: @selector(contentDone:)
	 name: MPMoviePlayerPlaybackDidFinishNotification
	 object: theMovie.moviePlayer];
	
	//state notifications
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(loadState:)
	 name: MPMoviePlayerLoadStateDidChangeNotification
	 object:theMovie.moviePlayer];
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(playbackState:)
	 name:MPMoviePlayerPlaybackStateDidChangeNotification
	 object:theMovie.moviePlayer];
	
	

	[theMovie.moviePlayer prepareToPlay];
	
	
	lbvc.currentContent = self;
	
	
}

-(void)loadState:(NSNotification *)aNotification {
	
	MPMoviePlayerController *mc = aNotification.object;
	
	
	if (mc.loadState == MPMovieLoadStateUnknown) {
		NSLog(@"load unknown");
	}
	if (mc.loadState == MPMovieLoadStatePlayable) {
		NSLog(@"load playable");
		[mc play];
	}
	if (mc.loadState == MPMovieLoadStatePlaythroughOK) {
		NSLog(@"load playok");
	}
	if (mc.loadState == MPMovieLoadStateStalled) {
		NSLog(@"load stalled");
	}

	//NSLog(@"loadsate: %@",  mc);
	
}
-(void)playbackState:(NSNotification *)aNotification {
	
	MPMoviePlayerController *mc = aNotification.object;
	
	if (mc.playbackState == MPMoviePlaybackStateStopped){
		NSLog(@"playback stopped");
	}
	if (mc.playbackState == MPMoviePlaybackStatePlaying){
		NSLog(@"playback playing");
	}
	if (mc.playbackState == MPMoviePlaybackStatePaused){
		NSLog(@"playback paused");
		//start next
		/*
		[[NSNotificationCenter defaultCenter] 
			postNotificationName:MPMoviePlayerPlaybackDidFinishNotification 
			object:mc];
		 */
		
		[mc stop];
	}
	if (mc.playbackState == MPMoviePlaybackStateInterrupted){
		NSLog(@"playback interrupted");
	}

	//NSLog(@"pbstate: %@", mc);
	
}

-(void)removeContentFrom:(LBSignViewController *)lbvc {
	
	NSLog(@"remove vitem");
	
	//MPMoviePlayerController  *movie = [aNotification object];
	
	//NSLog(@"movieDone");
	MPMoviePlayerViewController *theMovie = lbvc.theMovie;
	
	
    [[NSNotificationCenter defaultCenter]
	 removeObserver: lbvc
	 name: MPMoviePlayerPlaybackDidFinishNotification
	 object:  theMovie.moviePlayer];
	
	
	[[NSNotificationCenter defaultCenter]
	 removeObserver: self
	 name: MPMoviePlayerLoadStateDidChangeNotification
	 object: theMovie.moviePlayer];
	
	[[NSNotificationCenter defaultCenter]
	 removeObserver: self
	 name: MPMoviePlayerPlaybackStateDidChangeNotification
	 object: theMovie.moviePlayer];
	
	
	[theMovie.view removeFromSuperview];
	[theMovie.moviePlayer stop];
	//[theMovie release];
	
}


- (void)dealloc {
    //[theMovie release];
	
    [super dealloc];
}

@end
