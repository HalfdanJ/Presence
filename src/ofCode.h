#pragma once

#include "ofMain.h"
#include "ofxCocoaGLView.h"
#include "ofxLibwebsockets.h"
#include "InterfaceController.h"
#include "ofxAudioUnit.h"



class Communicator {
public:
    
    void setup();
    int reconnectTimer;
    void connect();

    ofxLibwebsockets::Client client;
    
    // websocket methods
    void onConnect( ofxLibwebsockets::Event& args );
    void onOpen( ofxLibwebsockets::Event& args );
    void onClose( ofxLibwebsockets::Event& args );
    void onIdle( ofxLibwebsockets::Event& args );
    void onMessage( ofxLibwebsockets::Event& args );
    void onBroadcast( ofxLibwebsockets::Event& args );
    
    void playKeySound();
    
    int keyCount;
    
    ofSoundPlayer typeSound[4];
    

};

@interface ofCode : ofxCocoaGLView {
    int keyAmplitude;
    Communicator communicator;
    
    NSWindow * overlayWindow;
    InterfaceController * interface;
    
}

@property (readwrite) NSWindow * overlayWindow;
@property InterfaceController * interface;

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

