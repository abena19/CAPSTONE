//
//  MyWallViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import "MyWallViewController.h"
#import <Parse/Parse.h>
#import "WallHeaderView.h"

@interface MyWallViewController ()

@end

@implementation MyWallViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUsername.text = [PFUser currentUser].username;
}


@end
