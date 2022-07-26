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
        }
    }];
    PFFileObject *locationImageFile = self.wall.locationImage;
    [locationImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.locationImageView.image = [UIImage imageWithData:imageData];
        }
    }];
    PFFileObject *mealImageFile = self.wall.mealImage;
    [mealImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            self.mealImageView.image = [UIImage imageWithData:imageData];
        }
    }];
    self.captionView.text = (NSString *)self.wall.caption;
    [self.dormLocationButton setTitle:self.wall.dormAddress forState:UIControlStateNormal];
}


@end
