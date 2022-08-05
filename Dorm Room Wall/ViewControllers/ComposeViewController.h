//
//  ComposeViewController.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/7/22.
//

#import <UIKit/UIKit.h>
#import "Wall.h"
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN


@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


- (IBAction)didTapLecturePhoto:(UITapGestureRecognizer *)sender;
- (IBAction)didTapLocationPhoto:(UITapGestureRecognizer *)sender;
- (IBAction)didTapMealPhoto:(UITapGestureRecognizer *)sender;

@property (strong, nonatomic) Wall *wallToPass;


@end

NS_ASSUME_NONNULL_END
