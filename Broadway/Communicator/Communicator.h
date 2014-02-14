//
//  Communicator.h
//  Broadway
//
//  Created by Alexander Fringes on 2/13/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SocketIO.h"
#import "Mover.h"

@interface Communicator : NSObject <SocketIODelegate>

- (id)init;

- (void)connect;

@end
