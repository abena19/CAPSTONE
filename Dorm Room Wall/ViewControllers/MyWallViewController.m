//
//  MyWallViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import "MyWallViewController.h"
#import <Parse/Parse.h>
#import "WallHeaderView.h"
#import "FBShimmering.h"
#import "FBShimmeringView.h"
#import "FBShimmeringLayer.h"

@interface MyWallViewController ()

@end

@implementation MyWallViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUsername.text = [PFUser currentUser].username;
    
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(self.currentUsername.frame.origin.x, self.currentUsername.frame.origin.y, self.currentUsername.frame.size.width, self.currentUsername.frame.size.height)];
    [self.view addSubview:shimmeringView];
    shimmeringView.contentView = self.currentUsername;

    // Start shimmering.
    shimmeringView.shimmering = YES;

}


@end
