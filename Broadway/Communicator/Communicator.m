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

@interface Communicator()

@property (strong, nonatomic) SocketIO *socketIO;
@property (strong, nonatomic) SocketIOPacket *packet;

@end

@implementation Communicator

-(id)init {
    self = [super init];
    if (self) {
        self.socketIO = [[SocketIO alloc] initWithDelegate:self];
    }
    return self;
}

-(void)connect {
    [self.socketIO connectToHost:@"printf.net" onPort:8001];
    
    NSMutableDictionary *driver = [NSMutableDictionary dictionary];
    [driver setObject:@"1" forKey:@"driver_id"];
    
    [self.socketIO sendEvent:@"register customer" withData:driver];
    
//    [[self.socketIO didReceiveEvent(SocketIOPacket *)self.packet];
    
//    NSLog(@"%@",self.packet);
}

- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveMessage() >>> data: %@", packet);
}

@end
