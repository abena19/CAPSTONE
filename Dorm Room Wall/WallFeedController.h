//
//  WallFeedController.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WallFeedController : UIViewController <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *wallArray;

@end

NS_ASSUME_NONNULL_END
