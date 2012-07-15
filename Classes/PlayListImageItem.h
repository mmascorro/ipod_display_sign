//
//  PlayListImage.h
//  LBSign
//
//  Created by Miguel Mascorro on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBSignViewController.h"
#import "PlayListItem.h"

@interface PlayListImageItem : PlayListItem {
	UIImageView *imgView;
	
}

@property (retain) UIImageView *imgView;


- (void)imageDone:(NSTimer*)theTimer;

- (void)startTimer;

-(void)playContent: (LBSignViewController *)lbvc;
-(void)removeContentFrom:(UIViewController*)lbvc;


@end
