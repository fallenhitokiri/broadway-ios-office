//
//  AppViewController.m
//  Broadway
//
//  Created by Alexander Fringes on 2/13/14.
//
//

#import "AppViewController.h"
#import "Communicator.h"

@interface AppViewController()

@property (strong, nonatomic) Communicator *communicator;
@property (strong, nonatomic) NSString *driverID;

@end


@implementation AppViewController

@synthesize rfduino;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.driverID = @"1";
    self.communicator = [[Communicator alloc] init];
    [self.communicator connect];
    
    rfduino.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
