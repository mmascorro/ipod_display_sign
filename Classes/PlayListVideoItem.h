//
//  PlayListVideoItem.h
//  LBSign
//
//  Created by Miguel Mascorro on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayListItem.h"
#import "LBSignViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PlayListVideoItem : PlayListItem {

	
	//MPMoviePlayerViewController *theMovie;
}
//@property (retain) MPMoviePlayerViewController *theMovie;

-(void)playContent: (LBSignViewController *)lbvc;
-(void)removeContentFrom:(UIViewController*)lbvc;

@end
