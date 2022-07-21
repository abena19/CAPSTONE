//
//  ParseQueryManager.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/20/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParseQueryManager : NSObject


+ (instancetype)shared;

- (void)fetchWallsFromCache:(void(^)(NSArray *feedWalls, NSError *error))completion;

- (void)fetchWallsFromNetworkOnly:(void(^)(NSArray *feedWalls, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
