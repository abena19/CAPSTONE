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


@protocol WallCellDelegate

- (void)didLikeOwnPost;

@end


@interface WallCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lectureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mealImageView;
@property (weak, nonatomic) IBOutlet UITextView *captionView;
@property (weak, nonatomic) IBOutlet UIButton *dormLocationButton;
- (IBAction)didTapLike:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *wallLikeButton;

@property (strong, nonatomic) Wall *wall;
- (void)setWall;

@property (nonatomic, weak) id<WallCellDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
