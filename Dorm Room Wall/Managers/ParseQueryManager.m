//
//  ParseQueryManager.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/20/22.
//

#import "ParseQueryManager.h"
#import <Parse/Parse.h>
#import "Wall.h"

@protocol Likeable;

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
    [wallQuery orderByDescending:createdAt];
    [wallQuery includeKey:author];
    wallQuery.limit = wallQueryLimit;
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


- (void)updateLike:(PFObject *)object withObjectClass:(Class)class withCompletion:(void (^)(BOOL succeeded, NSError *error))completion {
    
    BOOL isLikable = [class conformsToProtocol:@protocol(Likeable)];
    if (!isLikable) {
        NSAssert(isLikable, @"Assert: class is not Likeable");
        return;
    }
    
    if ([self checkWallAuthor]) {
        NSNumber *likesLeft = [PFUser currentUser][userLikesLeft];
        //        start of like count - initial/refill
        if ([likesLeft isEqualToNumber:[PFUser currentUser][likeCountLimit]]) {
            [self trackInitialLike:object:likesLeft];
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    completion(TRUE, nil);
                }
            }];
            
        } else if ([likesLeft isEqualToNumber:@0] || [likesLeft isEqualToNumber:@-1]) {  //depleted likes
            if ([self ifTimeForRefill]) {
                [self refillLikesAndLimit:object];
                [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        completion(TRUE, nil);
                    }
                }];
            } else {
                double numberOfHours = [self hoursSinceFirstLike];
                NSString *hours = [NSString stringWithFormat:doubleFormat, numberOfHours];
                [[NSNotificationCenter defaultCenter] postNotificationName:outOfLikes object:self userInfo:@{hours:emptyString}];
            }
            
        } else {
            [self decrementUserLikes:object :likesLeft];
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    completion(TRUE, nil);
                }
            }];
        }
        [object saveInBackground];
    }
}


-(BOOL) checkWallAuthor {
    return [PFUser currentUser][userWallCount] != 0;

}
 

- (void) addToUserWallNumber {
    [[PFUser currentUser] incrementKey:userWallCount];
    [[PFUser currentUser] saveInBackground];
}


- (NSDate*) dateNow {
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:dateStringFormat];
    return now;
}


- (BOOL) ifTimeForRefill {
    double numberOfHours = [self hoursSinceFirstLike];
    return numberOfHours >= hoursForRefill;
}


- (double) hoursSinceFirstLike {
    NSTimeInterval secondsBetween = [[self dateNow] timeIntervalSinceDate:[PFUser currentUser][timeSinceFirstLike]];
    double numberOfHours = secondsBetween / secondHourCount;
    return numberOfHours;
}


- (void) trackInitialLike:(PFObject *)object :(NSNumber*) likesLeft {
    [self decrementUserLikes:object :likesLeft];
    [PFUser currentUser][timeSinceFirstLike] = [self dateNow];
}


- (void) refillLikesAndLimit:(PFObject *)object {
    NSNumber* wallCount = [PFUser currentUser][userWallCount];
    NSNumber* likeLimit = [PFUser currentUser][likeCountLimit];
    NSNumber* refillLikeNumber = @(([wallCount intValue] * [likeLimit intValue]) / 5);
    [PFUser currentUser][likeCountLimit] = @([likeLimit intValue] + [refillLikeNumber intValue]);
    [PFUser currentUser][userLikesLeft] = [PFUser currentUser][likeCountLimit];
    object[usersLikeDictionary] = [self setLikeDictionary:object[usersLikeDictionary]];
}


- (void) decrementUserLikes:(PFObject *)object :(NSNumber*) likesLeft {
    [PFUser currentUser][userLikesLeft] = @([likesLeft intValue] - 1);
    object[usersLikeDictionary] = [self setLikeDictionary:object[usersLikeDictionary]];
}


- (NSMutableDictionary<NSString*, NSString*> *) setLikeDictionary:(NSMutableDictionary<NSString*, NSString*>*)likeDictionary {
    NSMutableDictionary<NSString*, NSString*> *dict = likeDictionary;
    [dict setValue:emptyString forKey:[PFUser currentUser].objectId];
    
    return dict;
}


- (BOOL) isInLikeDictionary:(PFObject *)object {
    return [object[userLikesDictionary] objectForKey:[PFUser currentUser].objectId] != nil;
}



@end
