//
//  HeaderCell.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/13/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Wall.h"
#import "WallCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
- (void)setHeader:(Wall *)wall;

@end

NS_ASSUME_NONNULL_END
