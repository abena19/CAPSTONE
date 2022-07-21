//
//  GMapsAPIManager.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/21/22.
//

#import "GMapsAPIManager.h"

@implementation GMapsAPIManager


+ (instancetype)shared {
    static GMapsAPIManager *sharedManager = nil;
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
