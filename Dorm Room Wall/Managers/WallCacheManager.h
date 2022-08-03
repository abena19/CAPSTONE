//
//  WallCacheManager.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 8/3/22.
//

#import <Foundation/Foundation.h>
#import "Wall.h"

NS_ASSUME_NONNULL_BEGIN


@protocol ExpiringWallCacheItem <NSObject>

@property (nonatomic, strong) NSDate *expiringCacheItemDate;

@end

@interface WallCacheManager : NSObject

@property (nonatomic, strong) NSCache *wallCache;
@property (nonatomic, assign) NSTimeInterval expiryTimeInterval;

- (id)expireWallMethod:(id)key;
- (void)setWallArrayInCache:(NSMutableArray*)wallArray forKey:(id)key;
- (NSMutableArray*)getWallArrayInCacheforKey:(id)key;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
