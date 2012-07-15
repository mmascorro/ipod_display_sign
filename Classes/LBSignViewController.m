//
//  LBSignViewController.m
//  LBSign
//
//  Created by Miguel Mascorro on 6/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "LBSignAppDelegate.h"

#import "LBSignViewController.h"

#import "PlayListItem.h"
#import "PlayListVideoItem.h"
#import "PlayListImageItem.h"


#import	<CFNetwork/CFNetwork.h>
#import <CoreFoundation/CoreFoundation.h>
#import <sys/socket.h>
#import <netinet/in.h>




@implementation LBSignViewController



NSNetService *service;

//need because of C function
void *refSelf;



@synthesize count;
@synthesize receivedData;
@synthesize playlistParser;

@synthesize playlist;
@synthesize newPlaylist;

@synthesize currentPLItem;
@synthesize currentContent;


@synthesize theMovie;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

//SOCKET HANDLING
void TCPServerAcceptCallBack (CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const void *data, void *info){
	
	CFSocketNativeHandle nativeSocketHandle = *(CFSocketNativeHandle *)data;
	
	CFReadStreamRef readStream = NULL;
	
	CFWriteStreamRef writeStream = NULL;
	
	CFStreamCreatePairWithSocket(kCFAllocatorDefault, nativeSocketHandle, &readStream, &writeStream);
	
	CFReadStreamSetProperty(readStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanFalse);
	CFWriteStreamSetProperty(writeStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanFalse);
	
	
	NSInputStream *ins = (NSInputStream *)readStream;
	[ins setDelegate:refSelf];
	[ins scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[ins open];
	
	
	
	CFRelease(readStream);
	CFRelease(writeStream);
	
	NSLog(@"ok");
	
	
	
}

/**/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
	
	[super viewDidLoad];
	

	self.count = 0;

	
	self.theMovie = [[MPMoviePlayerViewController alloc] init];
    self.theMovie.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    self.theMovie.moviePlayer.controlStyle = MPMovieControlStyleNone;
	
	
	playlist = [[NSMutableArray alloc] init];
	//currentContent = [[PlayListItem alloc] init];
	
	
	
	UISwipeGestureRecognizer *swipey = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipey:)];
	[self.view addGestureRecognizer:swipey];
	[swipey release];
	
	/*
	UITapGestureRecognizer *tappy = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTappy:)];
	[self.view addGestureRecognizer:tappy];
	[tappy release];
	*/
	
	
	[self setupSocket];
	
	[self getLatestList];
	
	
	
}


- (void) setupSocket {
	
	//for C func callback
	refSelf = self;
	

	CFSocketRef _server;
	
	_server = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketAcceptCallBack, (CFSocketCallBack)&TCPServerAcceptCallBack, NULL);
	
	struct sockaddr_in addr;
	memset(&addr, 0, sizeof(addr));
	addr.sin_len = sizeof(addr);
	addr.sin_family = AF_INET;
	addr.sin_port = htons(30000);
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	
	NSData *address4 = [NSData dataWithBytes:&addr length:sizeof(addr)];
	
	
	CFSocketSetAddress(_server, (CFDataRef)address4);
	
	
	CFRunLoopSourceRef sourceRef = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _server, 0);
	CFRunLoopAddSource(CFRunLoopGetCurrent(), sourceRef, kCFRunLoopCommonModes);
	CFRelease(sourceRef);
	
	//register with bonjour
	service = [[NSNetService alloc] initWithDomain:@"" type:@"_sign._tcp" name:@"" port:30000];
	[service publish];	
}


-(void)getLatestList {
	//connection
	
	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSLog(@"pref: %@", [defaults stringForKey:@"playlist_preference"]);
	
	
	NSString *playlistUrl = [defaults stringForKey:@"playlist_preference"];
	
	NSURL *plurl = [NSURL URLWithString:playlistUrl];
	
	NSURLRequest *rq = [NSURLRequest requestWithURL:plurl];
	
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:rq delegate:self];
	
	if(theConnection){
		receivedData = [[NSMutableData data] retain];
		
	}
	
	
}

-(void)handleSwipey:(UISwipeGestureRecognizer *)sender {
	
	//[self performSelector:NSSelectorFromString(@"getLatestList")];
	//[self getLatestList];
	NSLog(@"swipe");


	//[self getLatestList];
	
	
	//
	[currentContent removeContentFrom:self];
	[self.view removeFromSuperview];
	
	[UIApplication sharedApplication].idleTimerDisabled = NO;
	
	NSLog(@"- %@", self);
	
	
	 
	
}
-(void)handleTappy:(UISwipeGestureRecognizer *)sender {
	
	//[self performSelector:NSSelectorFromString(@"getLatestList")];
	//[self getLatestList];
	NSLog(@"tap");
	
	
	
	
		
}


-(void)startNewPlaylist:(NSNotification *)aNotification {
		
	[self playItem];
	
}

- (void) playItem {
	
	//NSLog(@"-- %@", playlist);
	
	if (self.count == [playlist count]) {
		self.count = 0;
		
		
	}
	[currentContent removeContentFrom:self];
	
	NSLog(@"gonna play %@", [playlist objectAtIndex:count]);
	[[playlist objectAtIndex:count] playContent:self];
	
	
	
}

- (void) contentDone:(NSNotification *) aNotification {

	NSLog(@"done with: %@", currentContent);
	
	//[currentContent removeContentFrom:self];
	
	self.count++;
	[self playItem];
	
}


 
//connection delegate stuff
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
	
    [receivedData setLength:0];
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
	
    [receivedData appendData:data];
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection

{
	
	[connection release];
	[self parsePlaylistXML];

	
	
	NSLog(@"end loading xml");
	[playlistParser release];
	

	
	//[currentContent removeContentFrom:self];
	

	[playlist setArray:newPlaylist];
	
	
	
	
	
	
	self.count = 0;
	[self playItem];
	
	[newPlaylist release];
	
}



// xml 

- (void)parsePlaylistXML {

	//BOOL success;
	
    playlistParser = [[NSXMLParser alloc] initWithData:receivedData];
    [playlistParser setDelegate:self];
    [playlistParser setShouldResolveExternalEntities:YES];
	
    [playlistParser parse];
	
	//NSLog(@"rd %@", receivedData);
	
	
}



// xml delegate
- (void)parser:(NSXMLParser *)parser 
	didStartElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName 
	attributes:(NSDictionary *)attributeDict {
	
	NSLog(@"didstart %@", elementName);
	
	if ( [elementName isEqualToString:@"playlist"]) {
        /*
		if (!newPlaylist) {
			newPlaylist = [[NSMutableArray alloc] init];
        } 
		 */
		newPlaylist = [[NSMutableArray alloc] init];
		
    }
	
	if ( [elementName isEqualToString:@"item"]) {
		
		if ([[attributeDict objectForKey:@"type"] isEqualToString:@"video"]) {
		
			currentPLItem = [[PlayListVideoItem alloc] init];
			
		} else if ([[attributeDict objectForKey:@"type"] isEqualToString:@"image"]) {
		
			currentPLItem = [[PlayListImageItem alloc] init];
			
		}
		
		
		
		
		NSString *src = [attributeDict objectForKey:@"src"];
		
		if (src) {
            NSLog(@"%@", src);
			currentPLItem.itemSrc = src;
		}
		
		
		
		NSString *itemType = [attributeDict objectForKey:@"type"];
		
		if (itemType) {
			NSLog(@"%@", itemType);
			currentPLItem.itemType = itemType;
			
		}
		
		
    }
	
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	
}


- (void)parser:(NSXMLParser *)parser 
	didEndElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName {
	
	
	NSLog(@"did end %@", elementName);
	
	//end of playlist
	if ( [elementName isEqualToString:@"playlist"] ) {
		
		[receivedData release];
		
		return;
	}
	//end of item data
	if ( [elementName isEqualToString:@"item"] ) {
		
        [newPlaylist addObject:currentPLItem];
		
		[currentPLItem release];
        return;
    }
	
	
	
}

//
// read in from socket
-(void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
	
	
	
	switch (eventCode) {
		case NSStreamEventOpenCompleted:
			
			
			break;
			
		case NSStreamEventHasBytesAvailable:
			
			NSLog(@"streamy");
			

			uint8_t buf[1024];
			unsigned int len = 0;
			len = [(NSInputStream *)stream read:buf maxLength:1024];
			
			if(len){
				
				//[_data appendBytes:(const void *)buf length:len];
				NSString *tmp = [[NSString alloc] initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
				
				
				SEL sl = NSSelectorFromString(tmp);
				if ([self respondsToSelector:sl]) {
					[self performSelector:sl];
					NSLog(@"can run %@", tmp);
				} else {
					NSLog(@"no selector for: %@", tmp);
				}
				
				
				//tbox.text = tmp;
				[tmp release];
				
			} else {
				//NSLog(@"no buffer");
			}
			//NSLog(@"gotit");
			
			break;
		case NSStreamEventEndEncountered:
			NSLog(@"closestream");
			
			[stream close];
			[stream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
			
			//[stream release];
			
			
			break;
	}
	
	
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[theMovie release];
	
	[service release];
	[playlist release];	
	[currentContent release];
    [super dealloc];
}

@end
