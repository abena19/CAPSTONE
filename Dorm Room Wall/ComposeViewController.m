//
//  ComposeViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/7/22.
//

#import "ComposeViewController.h"
#import "SceneDelegate.h"
#import "WallFeedController.h"
#import "Wall.h"
#import <Parse/Parse.h>

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *lecturePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *locationPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *mealPhoto;

@property (weak, nonatomic) IBOutlet UITextField *caption;

@property (nonatomic, strong) NSMutableArray *photoArray;

- (IBAction)didTapPostWall:(UIButton *)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    if ( self.locationPhoto.tag == 1) {
        [self.locationPhoto setImage:editedImage];
        self.locationPhoto.tag = 0;
    } else if ( self.lecturePhoto.tag == 2) {
        [self.lecturePhoto setImage:editedImage];
        self.lecturePhoto.tag = 0;
    } else if (self.mealPhoto.tag == 3) {
        [self.mealPhoto setImage:editedImage];
        self.mealPhoto.tag = 0;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapMealPhoto:(UITapGestureRecognizer *)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.mealPhoto.tag = 3;
    [self presentViewController:imagePickerVC animated:YES completion:nil];}


- (IBAction)didTapLocationPhoto:(UITapGestureRecognizer *)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.locationPhoto.tag = 1;
    [self presentViewController:imagePickerVC animated:YES completion:nil];}


- (IBAction)didTapLecturePhoto:(UITapGestureRecognizer *)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.lecturePhoto.tag = 2;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)didTapPostWall:(UIButton *)sender {
    [self.photoArray addObject:self.locationPhoto.image];
    [self.photoArray addObject:self.lecturePhoto.image];
    [self.photoArray addObject:self.mealPhoto.image];
    Wall *wall = [Wall postWallImage:self.photoArray withCaption:self.caption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
             NSLog(@"Error posting: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully posted the following caption: %@", self.caption.text);
        }
    }];
    [self.composeDelegate didPostWall:wall];
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
