//
//  Mover.m
//  Broadway
//
//  Created by Alexander Fringes on 2/13/14.
//
//

#import "Mover.h"

@implementation Mover

@synthesize rfduino;

- (void)startMovingLeft {
    uint8_t tx[4] = { 1, 0, 0, 0 };
    NSData *data = [NSData dataWithBytes:(void*)&tx length:4];
    NSLog(@"left implemented");
    [rfduino send:data];
}

- (void)stopMoving {
    uint8_t tx[4] = { 0, 0, 0, 0 };
    NSData *data = [NSData dataWithBytes:(void*)&tx length:4];
    NSLog(@"stop implemented");
    [rfduino send:data];
}

@end
