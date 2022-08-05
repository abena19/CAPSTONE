//
//  ParseQueryManager.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/20/22.
//

#import <Foundation/Foundation.h>
#import "Wall.h"
#import "Constants.h"
#import "Protocols.h"


NS_ASSUME_NONNULL_BEGIN

@interface ParseQueryManager : NSObject

+ (instancetype)shared;

- (void) fetchWalls:(NSInteger)fetchMethod withCompletion:(void(^)(NSArray *feedWalls, NSError *error))completion;
- (void)updateLike:(PFObject *)object withObjectClass:(Class)class withCompletion:(void (^)(BOOL succeeded, NSError *error))completion;
- (void) addToUserWallNumber;
- (BOOL) isInLikeDictionary:(PFObject *)object;

typedef NS_ENUM(NSInteger , cacheState) {
    QueryDefaultState = 1,
    QueryNetworkState = 2,
};

@end

NS_ASSUME_NONNULL_END
