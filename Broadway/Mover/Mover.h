//
//  Mover.h
//  Broadway
//
//  Created by Alexander Fringes on 2/13/14.
//
//

#import <Foundation/Foundation.h>

#import "RFduino.h"

@interface Mover : NSObject

- (void)startMovingLeft;
- (void)stopMoving;

@property(nonatomic, strong) RFduino *rfduino;

@end
