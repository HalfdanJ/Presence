#pragma once

#include "ofMain.h"
#include "ofxCocoaGLView.h"
#include "ofxLibwebsockets.h"



class Communicator {
public:
    
    void setup();
    
    ofxLibwebsockets::Client client;
    
    // websocket methods
    void onConnect( ofxLibwebsockets::Event& args );
    void onOpen( ofxLibwebsockets::Event& args );
    void onClose( ofxLibwebsockets::Event& args );
    void onIdle( ofxLibwebsockets::Event& args );
    void onMessage( ofxLibwebsockets::Event& args );
    void onBroadcast( ofxLibwebsockets::Event& args );
    
    int keyCount;
    
};

@interface testView : ofxCocoaGLView {
    int keyAmplitude;
    Communicator communicator;
}

- (void)setup;
- (void)update;
- (void)draw;
- (void)exit;

- (void)keyPressed:(int)key;
- (void)keyReleased:(int)key;
- (void)mouseMoved:(NSPoint)p;
- (void)mouseDragged:(NSPoint)p button:(int)button;
- (void)mousePressed:(NSPoint)p button:(int)button;
- (void)mouseReleased:(NSPoint)p button:(int)button;
- (void)windowResized:(NSSize)size;

- (void)changeColor:(id)sender;

- (void) keyWasPressedFunction:(NSEvent*)event;

@end

