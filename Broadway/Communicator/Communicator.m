//
//  Communicator.m
//  Broadway
//
//  Created by Alexander Fringes on 2/13/14.
//
//

#import "Communicator.h"
#import "SRWebSocket.h"
#import "SocketIO.h"
#import "SocketIOPacket.h"
#import "AppViewController.h"


@interface Communicator()

@property (strong, nonatomic) SocketIO *socketIO;
@property (strong, nonatomic) SocketIOPacket *packet;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSMutableArray *location;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) Mover *mover;

@end

@implementation Communicator

- (id)init {
    self = [super init];
    if (self) {
        self.socketIO = [[SocketIO alloc] initWithDelegate:self];
    }
    return self;
}

- (void)connect {
    [self.socketIO connectToHost:@"printf.net" onPort:8001];
    
    NSMutableDictionary *driver = [NSMutableDictionary dictionary];
    [driver setObject:@"1" forKey:@"driver_id"];
    
    [self.socketIO sendEvent:@"register customer" withData:driver];
}

- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    
    self.data = packet.args;
    self.location = [packet.args objectAtIndex:0];
    self.latitude = [self.location valueForKey: @"latitude"];
    
    if([self.latitude doubleValue]> 0.25) {
        NSLog(@"left");
        [self.mover startMovingLeft];
    } else if ([self.latitude doubleValue] < -0.25) {
        NSLog(@"right");
        [self.mover stopMoving];
    }
    
    NSLog(@"%@", self.latitude);
}

- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error {
    [self connect];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                    message:@"Socket Disconnected"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
