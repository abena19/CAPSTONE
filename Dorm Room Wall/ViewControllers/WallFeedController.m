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
#import "GMapViewController.h"
#import <Parse/Parse.h>
#import "Wall.h"
#import "WallCell.h"
#import "WallHeaderView.h"
#import "ParseQueryManager.h"
@import GoogleMaps;


@interface WallFeedController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, WallCellDelegate>

- (IBAction)didTapLogout:(id)sender;
- (IBAction)didTapLocation:(id)sender;

@end

@implementation WallFeedController

NSString *const loginControllerId = @"LoginViewController";
NSString *const wallCellId = @"WallCell";
NSString *const wallHeaderViewId = @"WallHeaderView";
NSString *const mapControllerId = @"GMapViewController";
NSString *const postNotification = @"TestNotification";
NSString *const wallArrayCached = @"wallArrayCached";
NSInteger const rowCount = 1;


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:postNotification object:nil];
}


- (void) postNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:postNotification]) {
        self.wallArray = [self.wallCache objectForKey:wallArrayCached];
        [self.wallFeedTableView reloadData];
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.wallFeedTableView.dataSource = self;
    self.wallFeedTableView.delegate = self;
    
    UINib *headerNib = [UINib nibWithNibName:wallHeaderViewId bundle:nil];
    
    [self.wallFeedTableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:wallHeaderViewId];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(postNotification:)
        name:postNotification
        object:nil];
    
    [self.wallFeedTableView reloadData];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.wallFeedTableView insertSubview:refreshControl atIndex:0];
    [self.wallFeedTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.wallFeedTableView setShowsVerticalScrollIndicator:FALSE];
    self.wallCache = [[NSCache alloc] init];
    [self fetchFeedWalls];
}


- (void)fetchFeedWalls {
    // check memory cache else upload from parse cache
    self.wallArray = [self.wallCache objectForKey:wallArrayCached];
    if (!self.wallArray) {
        [[ParseQueryManager shared] fetchWalls:QueryDefaultState withCompletion:^(NSArray *feedWalls, NSError *error) {
            if (feedWalls) {
                self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)feedWalls];
                [self.wallCache setObject:self.wallArray forKey:wallArrayCached];
            } else {
            }
            [self.wallFeedTableView reloadData];
        }];
    }
}


- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [[ParseQueryManager shared] fetchWalls:QueryNetworkState withCompletion:^(NSArray *feedWalls, NSError *error) {
        if (feedWalls) {
            self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)feedWalls];
            [refreshControl endRefreshing];
        } else {
        }
        [self.wallFeedTableView reloadData];
        }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WallCell *cell = [tableView dequeueReusableCellWithIdentifier:wallCellId forIndexPath:indexPath];
    Wall *wall = self.wallArray[indexPath.section];
    cell.wall = wall;
    [cell setWall];
    cell.delegate = self;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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


- (IBAction)didTapLocation:(id)sender {
    SceneDelegate *mapSceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:mapControllerId];
    GMapViewController *mapViewController = navController.childViewControllers[0];
    NSIndexPath *myIndexPath = [self.wallFeedTableView indexPathForCell:sender];
    Wall *wallToPass = self.wallArray[myIndexPath.row];
    mapViewController.dormAddress = wallToPass.dormAddress;
    mapSceneDelegate.window.rootViewController = navController;
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
