//
//  ParseQueryManager.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/20/22.
//

#import <Foundation/Foundation.h>
#import "Wall.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseQueryManager : NSObject


+ (instancetype)shared;

- (void) fetchWalls:(NSInteger)fetchMethod withCompletion:(void(^)(NSArray *feedWalls, NSError *error))completion;
- (void)updateLike:(Wall *)wall likeState:(BOOL)value withCompletion:(void (^)(Wall *wall, NSError *error))completion;

typedef NS_ENUM(NSInteger , cacheState) {
    QueryDefaultState = 1,
    QueryNetworkState = 2,
};

@end

NS_ASSUME_NONNULL_END
