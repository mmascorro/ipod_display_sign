//
//  PlayListImage.m
//  LBSign
//
//  Created by Miguel Mascorro on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayListImageItem.h"
#import "LBSignViewController.h"
#import <QuartzCore/CoreAnimation.h>

@implementation PlayListImageItem

@synthesize imgView;

-(void) playContent:(LBSignViewController *)lbvc{
	
	[UIApplication sharedApplication].idleTimerDisabled = YES;
	
	//NSLog(@"image plays now until stop: %@", self.itemSrc);
	
	
	NSURL *url = [NSURL URLWithString:self.itemSrc];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *image = [[UIImage alloc] initWithData:data];
	
	self.imgView = [[UIImageView alloc] initWithImage:image];
	
	
	CGRect bs = lbvc.view.bounds;
	imgView.frame = bs;
	
	imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[lbvc.view addSubview:imgView];
	imgView.contentMode = UIViewContentModeScaleAspectFit;
	
	[self startTimer];
	
	
	//animation
	CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	theAnimation.duration=.5;
	theAnimation.fromValue=[NSNumber numberWithFloat:0.0];
	theAnimation.toValue=[NSNumber numberWithFloat:01.0];
	[imgView.layer addAnimation:theAnimation forKey:@"animateOpacity"];
	

	
	
	// Register for the playback finished notification
	
	[[NSNotificationCenter defaultCenter]
	 
	 addObserver: lbvc
	 
	 selector: @selector(contentDone:)
	 
	 name: @"imageDidFinish"
	 
	 object: self];
	
	
	lbvc.currentContent = self;
	
	[image release];
	
}

- (void)imageDone:(NSTimer*)theTimer {
	
	//NSLog(@"img done");
	
	[self.imgView removeFromSuperview];
	[self.imgView release];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"imageDidFinish" object:self];
	
}

- (void)startTimer {
	[NSTimer scheduledTimerWithTimeInterval:5.0
		target:self
		selector:@selector(imageDone:)
		userInfo:nil
		repeats:NO];
	
}



-(void)removeContentFrom:(LBSignViewController *)lbvc {
	
	NSLog(@"remove imitem");
	[[NSNotificationCenter defaultCenter]
	 
	 removeObserver: lbvc
	 
	 name: @"imageDidFinish"
	 
	 object:self];
	
	
	
}

- (void)dealloc {
    [imgView release];
	
    [super dealloc];
}


@end
