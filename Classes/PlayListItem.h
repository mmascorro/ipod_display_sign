//
//  PlayListItem.h
//  xmlTest
//
//  Created by Miguel Mascorro on 7/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlayListItem : NSObject {

	NSString *itemSrc;
	NSString *itemType;
}


@property (nonatomic, retain) NSString *itemSrc;
@property (nonatomic, retain) NSString *itemType;

-(void)playContent;
-(void)removeContentFrom:(UIViewController*)lbvc;

@end
