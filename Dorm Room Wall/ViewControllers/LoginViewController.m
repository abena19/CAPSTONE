//
//  LoginViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/5/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "Wall.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)registerUser {
    PFUser *newUser = [PFUser user];  // initialize a user object
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    newUser[@"likeCountLimit"] = @5;
    self.userId = newUser.objectId;
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
        } else {
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}


- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
        } else {
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}


- (IBAction)loginUser:(id)sender {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        [self emptyFieldHandler];;
    } else {
        [self loginUser];
    }
}

- (IBAction)registerUser:(id)sender {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        [self emptyFieldHandler];
    } else {
        [self registerUser];
    }
}


- (void) emptyFieldHandler {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty Field!" message:@"Provide username or password" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancelAction];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
        }];
}

- (IBAction)registerUserGoogle:(id)sender {
}

- (IBAction)registerUserFB:(id)sender {
}

@end
