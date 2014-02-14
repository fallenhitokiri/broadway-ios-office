//
//  AppViewController.h
//  Broadway
//
//  Created by Alexander Fringes on 2/13/14.
//
//

#import <UIKit/UIKit.h>
#import "RFduinoDelegate.h"
#import "RFduino.h"

@interface AppViewController : UIViewController<RFduinoDelegate>

@property(nonatomic, strong) RFduino *rfduino;

@end
