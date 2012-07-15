//
//  LBSignViewController.h
//  LBSign
//
//  Created by Miguel Mascorro on 6/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlayListItem.h"


#import <MediaPlayer/MediaPlayer.h>

@interface LBSignViewController : UIViewController <NSXMLParserDelegate> {
	

	
	NSInteger count;
	
	NSMutableData *receivedData;
	NSXMLParser *playlistParser;
	NSMutableArray *playlist;
	
	PlayListItem *currentPLItem;
	PlayListItem *currentContent;
	
}


@property NSInteger count;

@property (retain) NSMutableArray *playlist;
@property (retain) NSMutableArray *newPlaylist;
@property (retain) NSMutableData *receivedData;

@property (retain) NSXMLParser *playlistParser;
@property (retain) PlayListItem *currentPLItem;

@property (retain) PlayListItem *currentContent;

@property (retain) MPMoviePlayerViewController *theMovie;

- (void) playItem;
- (void) parsePlaylistXML;
- (void) getLatestList;


- (void) setupSocket;

@end

