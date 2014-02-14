//
//  AppViewController.h
//  Broadway
//
//  Created by Alexander Fringes on 2/13/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RFduinoDelegate.h"
#import "RFduino.h"
#import "SocketIO.h"

@interface AppViewController : UIViewController<RFduinoDelegate, SocketIODelegate, CLLocationManagerDelegate>

@property(nonatomic, strong) RFduino *rfduino;

- (void)connect;

@end
