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
    }
    return self;
}




@end
