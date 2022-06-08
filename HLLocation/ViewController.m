//
//  ViewController.m
//  HLLocation
//
//  Created by JJB_iOS on 2022/6/8.
//

#import "ViewController.h"
#import "HLLocationNavigation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Response Event

- (IBAction)navAction:(UIButton *)sender {
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(29.563475, 106.583541);
    [HLLocationNavigation navToLocation:location
                           locationType:HLLocationTypeBD09
                                address:@"解放碑"
                                 fromVC:self];
}

@end
