//
//  ComposeViewController.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/7/22.
//

#import <UIKit/UIKit.h>
#import "Wall.h"

NS_ASSUME_NONNULL_BEGIN

//@protocol ComposeViewControllerDelegate
//- (void)didPostWall:(Wall *) wall;
//@end


@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


- (IBAction)didTapLecturePhoto:(UITapGestureRecognizer *)sender;
- (IBAction)didTapLocationPhoto:(UITapGestureRecognizer *)sender;
- (IBAction)didTapMealPhoto:(UITapGestureRecognizer *)sender;

@property (strong, nonatomic) Wall *wallToPass;


@end

NS_ASSUME_NONNULL_END
