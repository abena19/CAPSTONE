//
//  WallCell.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import "WallCell.h"
#import <Parse/Parse.h>
#import "Wall.h"
#import "WallCell.h"

@implementation WallCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setWall {
    // convert pffile object to image
    PFFileObject *lectureImageFile = self.wall.lectureImage;
    [lectureImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.lectureImageView.image = [UIImage imageWithData:imageData];
            [self.lectureImageView.layer setCornerRadius:5.0f];
            [self.lectureImageView.layer setMasksToBounds:YES];
        }
    }];
    PFFileObject *locationImageFile = self.wall.locationImage;
    [locationImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.locationImageView.image = [UIImage imageWithData:imageData];
            [self.locationImageView.layer setCornerRadius:5.0f];
            [self.locationImageView.layer setMasksToBounds:YES];
        }
    }];
    PFFileObject *mealImageFile = self.wall.mealImage;
    [mealImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.mealImageView.image = [UIImage imageWithData:imageData];
            [self.mealImageView.layer setCornerRadius:5.0f];
            [self.mealImageView.layer setMasksToBounds:YES];
        }
    }];
    self.captionView.text = (NSString *)self.wall.caption;
    [self.dormLocationButton setTitle:self.wall.dormAddress forState:UIControlStateNormal];
}

- (IBAction)didTapLike:(id)sender {
    [self.wallLikeButton setImage:[UIImage systemImageNamed:@"heart.fill"]
      forState:UIControlStateNormal];
}


@end
