//
//  AppViewController.m
//  Broadway
//
//  Created by Alexander Fringes on 2/13/14.
//
//

#import "AppViewController.h"

#import "SRWebSocket.h"
#import "SocketIO.h"
#import "SocketIOPacket.h"
#import "AppViewController.h"

@interface AppViewController()

@property (strong, nonatomic) SocketIO *socketIO;
@property (strong, nonatomic) SocketIOPacket *packet;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSMutableArray *location;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) NSString *driverID;

@end


@implementation AppViewController

@synthesize rfduino;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.pausesLocationUpdatesAutomatically = NO;
        [self.locationManager startUpdatingLocation];
    }
    
	self.driverID = @"1";
    self.socketIO = [[SocketIO alloc] initWithDelegate:self];
    
    [self connect];
    
    rfduino.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sockets

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
    
    if([self.latitude doubleValue]> 0.20) {
        NSLog(@"left");
        [self startMovingLeft];
    } else if ([self.latitude doubleValue] < -0.20) {
        NSLog(@"right");
        [self startMovingRight];
    } else {
        NSLog(@"stop");
        [self stopMoving];
    }
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

#pragma mark - Movement

- (void)startMovingLeft {
    uint8_t tx[4] = { 0, 1, 0, 0 };
    NSData *data = [NSData dataWithBytes:(void*)&tx length:4];
    NSLog(@"left implemented");
    [rfduino send:data];
}

- (void)startMovingRight {
    uint8_t tx[4] = { 0, 0, 1, 0 };
    NSData *data = [NSData dataWithBytes:(void*)&tx length:4];
    NSLog(@"right implemented");
    [rfduino send:data];
}

- (void)stopMoving {
    uint8_t tx[4] = { 0, 0, 0, 0 };
    NSData *data = [NSData dataWithBytes:(void*)&tx length:4];
    NSLog(@"stop implemented");
    [rfduino send:data];
}

@end
