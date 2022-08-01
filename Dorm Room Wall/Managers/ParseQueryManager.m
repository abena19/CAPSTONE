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


- (void) fetchWalls:(NSInteger)fetchMethod withCompletion:(void(^)(NSArray *feedWalls, NSError *error))completion {
    PFQuery *wallQuery = [Wall query];
    [wallQuery orderByDescending:@"createdAt"];
    [wallQuery includeKey:@"author"];
    wallQuery.limit = 5;
    switch (fetchMethod) {
        case QueryDefaultState:
            wallQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
            break;
            
        case QueryNetworkState:
            wallQuery.cachePolicy = kPFCachePolicyNetworkOnly;
            break;
    }
    [wallQuery findObjectsInBackgroundWithBlock:^(NSArray<Wall *> * _Nullable walls, NSError * _Nullable error) {
        if (walls) {
            NSArray *feedWalls = walls;
            completion(feedWalls, nil);
        } else {
        }
    }];
}
   

- (void)updateLike:(Wall *)wall withCompletion:(void (^)(Wall * wall, NSError *error))completion {
    if (wall.author != [PFUser currentUser]) {
        NSMutableDictionary<NSString*, NSString*> *dict = wall[@"usersLikeDictionary"];
        [dict setValue:@"" forKey:[PFUser currentUser].objectId];
        wall[@"usersLikeDictionary"] = dict;
        NSNumber *likesLeft = [PFUser currentUser][@"userLikesLeft"];
//        start of like count
        if (likesLeft == [PFUser currentUser][@"likeCountLimit"]) {
            [PFUser currentUser][@"userLikesLeft"] = @([likesLeft intValue] - 1);
            [PFUser currentUser][@"timeSinceFirstLike"] = [self dateNow];
            [[PFUser currentUser] saveInBackground];
        } else if (likesLeft > 0) {
            [PFUser currentUser][@"userLikesLeft"] = @([likesLeft intValue] - 1);
            [[PFUser currentUser] saveInBackground];
        } else if (likesLeft <= 0) {
            [PFUser currentUser][@"userLikesLeft"] = [PFUser currentUser][@"likeCountLimit"];
            [[PFUser currentUser] saveInBackground];
        } 
        [[PFUser currentUser] saveInBackground];
        [wall saveInBackground];
    }
}


- (NSDate*) dateNow {
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    return now;
}


@end
