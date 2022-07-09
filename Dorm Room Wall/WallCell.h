//
//  WallCell.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Wall.h"

NS_ASSUME_NONNULL_BEGIN

@interface WallCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lectureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mealImageView;
@property (weak, nonatomic) IBOutlet UITextView *captionView;

@property (strong, nonatomic) Wall *wall;

- (void)setWall;

@end

NS_ASSUME_NONNULL_END
