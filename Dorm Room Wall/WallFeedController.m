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
#import "Wall.h"
#import "WallCell.h"


@interface WallFeedController () <UITableViewDataSource, UITableViewDelegate>

- (IBAction)didTapLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *wallFeedTableView;

@end

@implementation WallFeedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wallFeedTableView.dataSource = self;
    self.wallFeedTableView.delegate = self;
    
    [self.wallFeedTableView reloadData];
    
    PFQuery *postQuery = [Wall query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 5;
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Wall *> * _Nullable walls, NSError * _Nullable error) {
        if (walls) {
            NSLog(@"😎😎😎 Successfully loaded home feed");
            self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)walls];
        } else {
            NSLog(@"😫😫😫 Error getting home feed: %@", error.localizedDescription);  // handle error
        }
        [self.wallFeedTableView reloadData];
    }];}


- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *loginSceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginSceneDelegate.window.rootViewController = loginViewController;  // switching content to LoginViewController
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WallCell"];
    Wall *wall = self.wallArray[indexPath.row];
    cell.wall = wall;
    [cell setWall];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    NSLog(@"%@", self.wallArray);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wallArray.count;
}


@end
