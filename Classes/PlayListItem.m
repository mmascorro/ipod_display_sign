//
//  PlayListItem.m
//  xmlTest
//
//  Created by Miguel Mascorro on 7/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayListItem.h"


@implementation PlayListItem

@synthesize itemSrc;
@synthesize itemType;


- (id) init {
    self = [super init];
	
    if (self != nil)
    {
        // your code here
    }
	
    return self;
}

-(void)playContent {
	
	
}

-(void)removeContentFrom:(UIViewController *)lbvc {
	
	
}
- (void)dealloc {
    [itemType release];
	[itemSrc release];
	
    [super dealloc];
}


@end



