//
//  ViewController.m
//  Broadway
//
//  Created by Alexander Fringes on 2/13/14.
//
//

#import "ViewController.h"
#import "Communicator.h"

@interface ViewController ()

@property (strong, nonatomic) Communicator *communicator;
@property (strong, nonatomic) NSString *driverID;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.driverID = @"1";
    self.communicator = [[Communicator alloc] init];
    [self.communicator connect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
