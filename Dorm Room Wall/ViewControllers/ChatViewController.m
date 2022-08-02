//
//  ChatViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "RNFrostedSidebar.h"

@interface ChatViewController () <RNFrostedSidebarDelegate>
- (IBAction)didTapSideBar:(id)sender;
@property (nonatomic, weak) RNFrostedSidebar *frostedSideBar;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSideBar];
}


- (void) setSideBar {
    NSArray *images = @[
                        [UIImage systemImageNamed:@"square.and.pencil"],
                        [UIImage systemImageNamed:@"trash.slash"],
                        [UIImage systemImageNamed:@"paperplane"],
                        [UIImage systemImageNamed:@"heart"],
                        [UIImage systemImageNamed:@"heart.fill"],
                        [UIImage systemImageNamed:@"person.circle.fill"]
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
