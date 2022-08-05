//
//  ProfileViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "RNFrostedSidebar.h"

@interface ProfileViewController () <RNFrostedSidebarDelegate>
- (IBAction)didTapSideBar:(id)sender;
@property (nonatomic, weak) RNFrostedSidebar *frostedSideBar;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSideBar];
}


- (void) setSideBar {
    NSArray *images = @[
                        [UIImage systemImageNamed:squarePencilName],
                        [UIImage systemImageNamed:trashName],
                        [UIImage systemImageNamed:paperPlaneName],
                        [UIImage systemImageNamed:heartImageName],
                        [UIImage systemImageNamed:heartFillImageName],
                        [UIImage systemImageNamed:profileImageName]
                        ];

    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.tintColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    self.frostedSideBar = callout;
    callout.delegate = self;
    [callout show];
}


- (IBAction)didTapSideBar:(id)sender {
    [self.frostedSideBar show];
}


- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {

}


@end
