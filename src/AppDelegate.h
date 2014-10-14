#import <Cocoa/Cocoa.h>
#import "ofxCocoaGLView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow *window;
    IBOutlet ofxCocoaGLView* ofApp;
    NSMenu *menu;
    NSStatusItem *_statusItem;
}

@property (assign) IBOutlet NSMenu *menu;
@property (readwrite, retain) IBOutlet NSStatusItem *statusItem;
@property (assign) IBOutlet NSWindow *window;

- (IBAction)openSettings:(id)sender;


@end    
