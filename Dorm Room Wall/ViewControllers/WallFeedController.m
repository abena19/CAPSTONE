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


@interface WallFeedController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

- (IBAction)didTapLogout:(id)sender;
- (IBAction)didTapLocation:(id)sender;

@end

@implementation WallFeedController

NSString *const loginControllerId = @"LoginViewController";
NSString *const wallCellId = @"WallCell";
NSString *const wallHeaderViewId = @"WallHeaderView";
NSString *const mapControllerId = @"GMapViewController";
NSString *const postNotification = @"TestNotification";
NSInteger const rowCount = 1;



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:postNotification object:nil];
}


- (id) init {
    self = [super init];
    if (!self) return nil;
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(receiveTestNotification:)
        name:postNotification
        object:nil];
    return self;
}


- (void) receiveTestNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:postNotification]) {
        [[ParseQueryManager shared] fetchWallsFromNetworkOnly:^(NSArray *feedWalls, NSError *error) {
            if (feedWalls) {
                self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)feedWalls];
            } else {
            }
            [self.wallFeedTableView reloadData];
            }
        ];
    }
}


- (void) viewWillAppear:(BOOL)animated {
        self.timeSinceLoginUser = [NSTimer scheduledTimerWithTimeInterval:180.0  target:self selector:@selector(actionOnTimer) userInfo:nil repeats:YES];
}


- (void) actionOnTimer {
        [[ParseQueryManager shared] fetchWallsFromNetworkOnly:^(NSArray *feedWalls, NSError *error) {
            if (feedWalls) {
                self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)feedWalls];
            } else {
            }
            [self.wallFeedTableView reloadData];
            }
        ];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.wallFeedTableView.dataSource = self;
    self.wallFeedTableView.delegate = self;
    
    UINib *headerNib = [UINib nibWithNibName:wallHeaderViewId bundle:nil];
    [self.wallFeedTableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:wallHeaderViewId];
    
    [self.wallFeedTableView reloadData];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.wallFeedTableView insertSubview:refreshControl atIndex:0];
    
    [self fetchFeedWalls];
}


- (void)fetchFeedWalls {
    [[ParseQueryManager shared] fetchWallsFromCache:^(NSArray *feedWalls, NSError *error) {
        if (feedWalls) {
            self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)feedWalls];
        } else {
        }
        [self.wallFeedTableView reloadData];
        }
    ];
}


- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [[ParseQueryManager shared] fetchWallsFromNetworkOnly:^(NSArray *feedWalls, NSError *error) {
        if (feedWalls) {
            self.wallArray = [NSMutableArray arrayWithArray:(NSArray*)feedWalls];
            [refreshControl endRefreshing];
        } else {
        }
        [self.wallFeedTableView reloadData];
        }
    ];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WallCell *cell = [tableView dequeueReusableCellWithIdentifier:wallCellId forIndexPath:indexPath];
    Wall *wall = self.wallArray[indexPath.section];
    cell.wall = wall;
    [cell setWall];
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
