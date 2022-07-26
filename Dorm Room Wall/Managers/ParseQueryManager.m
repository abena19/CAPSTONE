//
//  ParseQueryManager.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/20/22.
//

#import "ParseQueryManager.h"
#import <Parse/Parse.h>
#import "Wall.h"

@interface ParseQueryManager()

@end

@implementation ParseQueryManager


+ (instancetype)shared {
    static ParseQueryManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


- (instancetype)init {
    if (self) {      
    }
    return self;
}


- (void)fetchWallsFromCache:(void(^)(NSArray *feedWalls, NSError *error))completion {
    PFQuery *wallQuery = [Wall query];
    [wallQuery orderByDescending:@"createdAt"];
    [wallQuery includeKey:@"author"];
    wallQuery.limit = 5;
    wallQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;  //check cache for query else network
    [wallQuery findObjectsInBackgroundWithBlock:^(NSArray<Wall *> * _Nullable walls, NSError * _Nullable error) {
        if (walls) {
            NSArray *feedWalls = walls;
            completion(feedWalls, nil);
        } else {
            NSLog(@"😫😫😫 Error getting home feed: %@", error.localizedDescription); // handle error
        }
    }];
}


- (void)fetchWallsFromNetworkOnly:(void(^)(NSArray *feedWalls, NSError *error))completion {
    PFQuery *wallQuery = [Wall query];
    [wallQuery orderByDescending:@"createdAt"];
    [wallQuery includeKey:@"author"];
    wallQuery.limit = 5;
    wallQuery.cachePolicy = kPFCachePolicyNetworkOnly;  //check cache for query else network
    [wallQuery findObjectsInBackgroundWithBlock:^(NSArray<Wall *> * _Nullable walls, NSError * _Nullable error) {
        if (walls) {
            NSArray *feedWalls = walls;
            completion(feedWalls, nil);
        } else {
            NSLog(@"😫😫😫 Error getting home feed: %@", error.localizedDescription);  // handle error
        }
    }];
}


@end
