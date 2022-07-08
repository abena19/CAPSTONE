//
//  WallFeedController.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WallFeedController : UIViewController <UITableViewDataSource, ComposeViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *wallArray;

@end

NS_ASSUME_NONNULL_END
