#import "AppDelegate.h"

@implementation AppDelegate

@synthesize menu;
@synthesize window;
@synthesize statusItem = _statusItem;

- (void)dealloc
{
    [super dealloc];
}

-(void)awakeFromNib{
    NSLog(@"Awake");
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    NSImage *menuIcon = [NSImage imageNamed:@"Menu Icon"];
    NSImage *highlightIcon = [NSImage imageNamed:@"Menu Icon"]; // Yes, we're using the exact same image asset.
    [highlightIcon setTemplate:YES]; // Allows the correct highlighting of the icon when the menu is clicked.
    
    [[self statusItem] setImage:menuIcon];
    [[self statusItem] setAlternateImage:highlightIcon];
    [[self statusItem] setMenu:[self menu]];
    [[self statusItem] setHighlightMode:YES];
}


- (IBAction)openSettings:(id)sender {
}


@end
