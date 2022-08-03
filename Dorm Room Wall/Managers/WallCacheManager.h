//
//  WallCacheManager.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 8/3/22.
//

#import <Foundation/Foundation.h>
#import "Wall.h"

NS_ASSUME_NONNULL_BEGIN

@interface WallCacheManager : NSObject

@property (nonatomic, strong) NSCache *wallCache;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
