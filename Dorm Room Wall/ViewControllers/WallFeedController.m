//
//  WallFeedController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import "WallFeedController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import <Parse/Parse.h>
#import "Wall.h"
#import "WallCell.h"
#import "HeaderCell.h"


@interface WallFeedController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

- (IBAction)didTapLogout:(id)sender;
@property (weak, nonatomic) WallCell *cell;

@end

@implementation WallFeedController

NSString *const loginControllerId = @"LoginViewController";
NSString *const wallCellId = @"WallCell";
NSString *const headerCellId = @"HeaderCell";
NSInteger const rowCount = 1;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.wallFeedTableView.dataSource = self;
    self.wallFeedTableView.delegate = self;
    [self.wallFeedTableView reloadData];
    PFQuery *wallQuery = [Wall query];
    [wallQuery orderByDescending:@"createdAt"];
    [wallQuery includeKey:@"author"];
    wallQuery.limit = 5;
    [wallQuery findObjectsInBackgroundWithBlock:^(NSArray<Wall *> * _Nullable walls, NSError * _Nullable error) {
        if (walls) {
            NSLog(@"😎😎😎 Successfully loaded home feed");
            self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)walls];
        } else {
            NSLog(@"😫😫😫 Error getting home feed: %@", error.localizedDescription);
        }
        [self.wallFeedTableView reloadData];
    }];

}


- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *loginSceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:loginControllerId];
    loginSceneDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    self.cell = [tableView dequeueReusableCellWithIdentifier:wallCellId];
    Wall *wall = self.wallArray[indexPath.row];
    NSLog(@"%@", wall);
    self.cell.wall = wall;
    [self.cell setWall];
    [self.cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSLog(@"%@", self.wallArray);
    return self.cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowCount;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:headerCellId];
    [headerCell setHeader:self.cell.wall];
    return headerCell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.wallArray.count;
}


@end
