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
#import "WallHeaderView.h"


@interface WallFeedController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

- (IBAction)didTapLogout:(id)sender;

@end

@implementation WallFeedController

NSString *const loginControllerId = @"LoginViewController";
NSString *const wallCellId = @"WallCell";
NSString *const wallHeaderViewId = @"WallHeaderView";
NSInteger const rowCount = 1;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.wallFeedTableView.dataSource = self;
    self.wallFeedTableView.delegate = self;
    
    self.didPost = NO;
    
    UINib *headerNib = [UINib nibWithNibName:wallHeaderViewId bundle:nil];
    [self.wallFeedTableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:wallHeaderViewId];
    
    [self.wallFeedTableView reloadData];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.wallFeedTableView insertSubview:refreshControl atIndex:0];
    [self fetchWalls];
}


- (void) viewWillAppear:(BOOL)animated {
        self.timeSinceLoginUser = [NSTimer scheduledTimerWithTimeInterval:60.0  target:self selector:@selector(actionOnTimer) userInfo:nil repeats:YES];
}


- (void) actionOnTimer {
    if (self.didPost) {
        [[self queryWalls] clearCachedResult];
        [self.wallFeedTableView reloadData];
        self.didPost = NO;
    }
}


- (PFQuery *)queryWalls {
    PFQuery *wallQuery = [Wall query];
    [wallQuery orderByDescending:@"createdAt"];
    [wallQuery includeKey:@"author"];
    wallQuery.limit = 5;
    return wallQuery;
}



- (void)fetchWalls {
    PFQuery *wallQuery = [self queryWalls];
    NSLog(@"%d", [wallQuery hasCachedResult]);
    wallQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;  //check cache for query else network
    [wallQuery findObjectsInBackgroundWithBlock:^(NSArray<Wall *> * _Nullable walls, NSError * _Nullable error) {
       if (walls) {
           NSLog(@"😎😎😎 Successfully loaded home feed");
           self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)walls];
       } else {
           NSLog(@"😫😫😫 Error getting home feed: %@", error.localizedDescription);  // handle error
       }
       [self.wallFeedTableView reloadData];
   }];
}


- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    PFQuery *wallQuery = [self queryWalls];
    wallQuery.cachePolicy = kPFCachePolicyNetworkOnly;  //saves new data from network to cache
    [wallQuery findObjectsInBackgroundWithBlock:^(NSArray<Wall *> * _Nullable walls, NSError * _Nullable error) {
       if (walls) {
           NSLog(@"😎😎😎 Successfully refreshed home feed");
           self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)walls];
           [refreshControl endRefreshing];
       } else {
           NSLog(@"😫😫😫 Error refreshing home feed: %@", error.localizedDescription);  // handle error
       }
       [self.wallFeedTableView reloadData];
   }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WallCell *cell = [tableView dequeueReusableCellWithIdentifier:wallCellId forIndexPath:indexPath];
    Wall *wall = self.wallArray[indexPath.section];
    cell.wall = wall;
    [cell setWall];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSLog(@"%@", self.wallArray);
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowCount;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.wallArray count];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WallHeaderView *wallHeader = (WallHeaderView *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:wallHeaderViewId];
    Wall *wall = self.wallArray[section];
    wallHeader.headerUsername.text = (NSString *)wall.author.username;
    wallHeader.wallAuthor = wall.author;
    return wallHeader;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}



- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *loginSceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:loginControllerId];
    loginSceneDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    }];
}


@end
