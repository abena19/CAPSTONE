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
#import "ParseQueryManager.h"

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
    [self setWallLikeStateWithHeart];
    UITapGestureRecognizer *doubleTap =
          [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(didDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.contentView addGestureRecognizer:doubleTap];
}



- (void)didDoubleTap:(UITapGestureRecognizer *)recognizer {
    UIView *gestureView = recognizer.view;
    UIImageView *heart =[[UIImageView alloc] initWithFrame:CGRectMake(gestureView.center.x, gestureView.center.y, gestureView.frame.size.width/4, gestureView.frame.size.width/4)];
    heart.tintColor = [UIColor redColor];
    heart.alpha = 0;
    [heart setImage:[UIImage systemImageNamed:@"heart.fill"]];
    [gestureView addSubview:heart];
    [gestureView layoutIfNeeded];
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
        [UIView transitionWithView:gestureView duration:1 options:UIViewAnimationOptionTransitionNone animations:^{heart.alpha = 1;} completion:^(BOOL finished) {
                [UIView transitionWithView:gestureView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{heart.alpha = 0;} completion:^(BOOL finished) {
                    [heart removeFromSuperview];
                }];
            }];
        });
    [self likeCheck];
}



- (IBAction)didTapLike:(id)sender {
    [self likeCheck];
}



- (void) likeCheck {
    BOOL isUserAuthor = [self.wall.author.username isEqual:[PFUser currentUser].username];
    if (!isUserAuthor) {
        if (![self isInLikeDictionary]) {
            [[ParseQueryManager shared] updateLike:self.wall withCompletion:^(Wall * _Nonnull wall, NSError * _Nonnull error) {
        }];
        [self.wallLikeButton setImage:[UIImage systemImageNamed:@"heart.fill"]
          forState:UIControlStateNormal];
        }
    } else {
        [self.delegate didLikeOwnPost];
    }
}


- (BOOL) isInLikeDictionary {
    return [self.wall[@"usersLikeDictionary"] objectForKey:[PFUser currentUser].objectId] != nil;
}


- (void) setWallLikeStateWithHeart {
    if (![self isInLikeDictionary]) {
        [self.wallLikeButton setImage:[UIImage systemImageNamed:@"heart"]
                  forState:UIControlStateNormal];
    } else {
        [self.wallLikeButton setImage:[UIImage systemImageNamed:@"heart.fill"]
                  forState:UIControlStateNormal];
    }
}


@end
