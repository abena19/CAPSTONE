//
//  ExpiringWallArray.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 8/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpiringWallArray : NSObject

@property (nonatomic, strong) NSDate *expiringCacheItemDate;
@property (nonatomic, strong) NSMutableArray* expiringWallArray;

@end

NS_ASSUME_NONNULL_END
