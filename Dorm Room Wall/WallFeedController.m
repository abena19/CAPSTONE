//
//  WallFeedController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import "WallFeedController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>


@interface WallFeedController ()
- (IBAction)didTapLogout:(id)sender;

@end

@implementation WallFeedController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *loginSceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginSceneDelegate.window.rootViewController = loginViewController;  // switching content to LoginViewController
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    }];
}
@end
