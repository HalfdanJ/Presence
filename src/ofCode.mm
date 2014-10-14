#import "ofCode.h"
#include <stdlib.h>

void Communicator::setup(){
    connect();

    client.addListener(this);
    
    ofSetDataPathRoot("data/data");
/*    typeSound[0].loadSound(ofToDataPath("click1.aif",true));
    typeSound[1].loadSound(ofToDataPath("click2.aif",true));
    typeSound[2].loadSound(ofToDataPath("click3.aif",true));
        typeSound[3].loadSound(ofToDataPath("click4.aif",true));*/
    
    typeSound[0].loadSound(ofToDataPath("click5.aif",true));
   /* reverb = ofxAudioUnit(kAudioUnitType_Effect,
                          kAudioUnitSubType_MatrixReverb);

    
    filePlayer.connectTo(reverb).connectTo(output);

    output.start();
    filePlayer.setFile(ofFilePath::getAbsolutePath("laptop_notebook_return.aiff"));
*/
   //filePlayer.loop();

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
    //    playKeySound();
        keyCount = 100;
    } else {
        playKeySound();
        keyCount = 255;
    }

    

}

void Communicator::playKeySound(){
    //typeSound.setSpeed(2);
//    typeSound.setPan(ofRandom(0.4,0.6));
//    int sound = floor(ofRandom(4));
    int sound = 0;
    typeSound[sound].setSpeed(ofRandom(0.9,1.0));
    typeSound[sound].play();

        //filePlayer.loop(1);
    
    
    
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
    keyAmplitude = 255;
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