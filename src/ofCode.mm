#import "ofCode.h"
#include <stdlib.h>

//https://www.freesound.org/people/Tomlija/sounds/75372/


void Communicator::setup(){
    connect();

    client.addListener(this);
    
    ofSetDataPathRoot("data/data");
    typeSound.loadSound(ofToDataPath("laptop_notebook_return.mp3",true));

}

void Communicator::connect(){
    client.connect("dry-reef-2121.herokuapp.com",80);
    //client.connect("127.0.0.1",5000);
}

//--------------------------------------------------------------
void Communicator::onConnect( ofxLibwebsockets::Event& args ){
    cout<<"on connected"<<endl;
}

//--------------------------------------------------------------
void Communicator::onOpen( ofxLibwebsockets::Event& args ){
    cout<<"on open"<<endl;
    
}

//--------------------------------------------------------------
void Communicator::onClose( ofxLibwebsockets::Event& args ){
    cout<<"on close"<<endl;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        ofSetLogLevel(OF_LOG_VERBOSE);
        ofLogVerbose()<<"Reconnect";
        connect();
        ofSetLogLevel(OF_LOG_ERROR);
    });
}

//--------------------------------------------------------------
void Communicator::onIdle( ofxLibwebsockets::Event& args ){
    cout<<"on idle"<<endl;
}

//--------------------------------------------------------------
void Communicator::onMessage( ofxLibwebsockets::Event& args ){
    cout<<"got message "<<args.message<<endl;
    
    if(args.message == "OK"){
        keyCount = 100;
    } else {
        playKeySound();
        keyCount = 255;
    }

    

}

void Communicator::playKeySound(){
    //typeSound.setSpeed(2);
//    typeSound.setPan(ofRandom(0.4,0.6));
    typeSound.play();
}

//--------------------------------------------------------------
void Communicator::onBroadcast( ofxLibwebsockets::Event& args ){
    cout<<"got broadcast "<<args.message<<endl;
}



@implementation ofCode
@synthesize overlayWindow, interface;

- (void)setup
{
    int r = 255;
    int g = 0;
    int b = 0;
    
    BOOL trusted = AXIsProcessTrusted();
    NSLog(@"Trusted: %i",trusted);
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyDownMask) handler:^(NSEvent *event){
        [self keyWasPressedFunction: event];
    }];
    
    
    [NSEvent addLocalMonitorForEventsMatchingMask:(NSKeyDownMask) handler:^NSEvent *(NSEvent *event) {
        [self keyWasPressedFunction: event];
        return event;
    }];
    
    communicator.setup();
    
    /*
    
    // Transparent UI window
    NSRect wRect = (self.window.frame);
    NSView *contentView = self.window.contentView;
    NSRect cRect = (contentView.frame);
    NSRect rect = NSRectFromCGRect( CGRectMake(wRect.origin.x, wRect.origin.y, cRect.size.width, cRect.size.height) );
    self.overlayWindow = [[NSWindow alloc]initWithContentRect:rect
                                                    styleMask:NSBorderlessWindowMask
                                                      backing:NSBackingStoreBuffered
                                                        defer:NO];
    self.overlayWindow.backgroundColor = [NSColor clearColor];
    [self.overlayWindow setOpaque:NO];
    // Add it to the window which contains our NSOpenGLView
    [self.window addChildWindow:self.overlayWindow ordered:NSWindowAbove];
    
    // Place UI in overlay window
    self.interface = [[InterfaceController alloc] initWithNibName:@"Interface" bundle:nil];
    [self.overlayWindow.contentView addSubview:self.interface.view];
 */
    
}

- (void)update
{
    if(keyAmplitude > 0){
        keyAmplitude-= 15;
    }
    
    if(communicator.keyCount > 0){
        communicator.keyCount-= 15;
    }
}

- (void)draw
{
    NSLog(@"draw");
    ofSetColor(ofClamp(keyAmplitude,0,255));
    ofRect(0,0,ofGetWidth()*0.5, ofGetHeight());
    
    ofSetColor(ofClamp(communicator.keyCount,0,255));
    ofRect(ofGetWidth()*0.5,0,ofGetWidth()*0.5, ofGetHeight());
}

- (void)exit
{
    
}

-(void)changeColor:(id)sender
{
}

- (void) keyWasPressedFunction:(NSEvent*)event{
  //  NSLog(@"%@",event);
    keyAmplitude = 255;
  //  communicator.client.send([[[self.interface password] stringValue] cStringUsingEncoding:NSUTF8StringEncoding]);
      communicator.client.send("key");
    communicator.playKeySound();
}

- (void)keyPressed:(int)key
{
    
}

- (void)keyReleased:(int)key
{
    
}

- (void)mouseMoved:(NSPoint)p
{
    
}

- (void)mouseDragged:(NSPoint)p button:(int)button
{
    
}

- (void)mousePressed:(NSPoint)p button:(int)button
{
    
}

- (void)mouseReleased:(NSPoint)p button:(int)button
{
    
}

- (void)windowResized:(NSSize)size
{
    
}

@end