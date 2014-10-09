#import "testView.h"
#include <stdlib.h>


void Communicator::setup(){
    ofSetLogLevel(OF_LOG_VERBOSE);

    client.connect("dry-reef-2121.herokuapp.com",80);
//        client.connect("localhost",5000);
    ofSetLogLevel(OF_LOG_ERROR);
    
    client.addListener(this);


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
}

//--------------------------------------------------------------
void Communicator::onIdle( ofxLibwebsockets::Event& args ){
    cout<<"on idle"<<endl;
}

//--------------------------------------------------------------
void Communicator::onMessage( ofxLibwebsockets::Event& args ){
    cout<<"got message "<<args.message<<endl;
    keyCount = 255;
}

//--------------------------------------------------------------
void Communicator::onBroadcast( ofxLibwebsockets::Event& args ){
    cout<<"got broadcast "<<args.message<<endl;
}



@implementation testView

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
    NSLog(@"%@",event);
    keyAmplitude = 255;
    communicator.client.send("key");
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