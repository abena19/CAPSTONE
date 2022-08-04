//
//  WallCacheManager.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 8/3/22.
//

#import "WallCacheManager.h"
#import <Parse/Parse.h>
#import "Wall.h"

@interface WallCacheManager()

@end

@implementation WallCacheManager

+ (instancetype)shared {
    static WallCacheManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


- (instancetype)init {
    if (self) {
        self.wallCache = [[NSCache alloc] init];
        self.expiryTimeInterval = 300;
    }
    return self;
}


- (id)expireWallMethod:(id)key {
    @try {
        ExpiringWallArray *expiringWallArrayCached = [self.wallCache objectForKey:key];
        if (expiringWallArrayCached) {
            NSTimeInterval timeSinceCache = fabs([expiringWallArrayCached.expiringCacheItemDate timeIntervalSinceNow]);
            if (timeSinceCache > self.expiryTimeInterval) {
                [self.wallCache removeObjectForKey:key];
                return nil;
            }
        }
        return expiringWallArrayCached;
    }
    
    @catch (NSException *exception) {
        return nil;
    }
}


- (void)setWallArrayInCache:(NSMutableArray*)wallArray forKey:(id)key {
    ExpiringWallArray *expiringWallArrayItem = [[ExpiringWallArray alloc]init];
    expiringWallArrayItem.expiringWallArray = wallArray;
    expiringWallArrayItem.expiringCacheItemDate = [NSDate date];
    [self.wallCache setObject:expiringWallArrayItem forKey:key];
}


- (NSMutableArray*)getWallArrayInCacheforKey:(id)key {
    [[WallCacheManager shared] expireWallMethod:key];
    ExpiringWallArray *expiringWallArrayItem = [self.wallCache objectForKey:key];
    NSMutableArray* wallArray = expiringWallArrayItem.expiringWallArray;
    return wallArray;
}

@end
