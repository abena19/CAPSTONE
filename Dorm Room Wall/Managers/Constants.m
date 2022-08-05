//
//  Constants.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 8/5/22.
//

#import "Constants.h"

@implementation Constants


//PARSE CONSTANTS
NSString *const usersLikeDictionary = @"usersLikeDictionary";
NSString *const userLikesLeft = @"userLikesLeft";
NSString *const likeCountLimit = @"likeCountLimit";
NSString *const timeSinceFirstLike = @"timeSinceFirstLike";
NSString *const userWallCount = @"userWallCount";
NSString *const createdAt = @"createdAt";
NSString *const author = @"author";
NSString *const outOfLikes = @"OutOfLikes";
NSString *const dateStringFormat = @"HH:mm:ss";
NSString *const emptyString = @"";
NSString *const doubleFormat = @"%f";
NSInteger const secondHourCount = 3600;
NSInteger const hoursForRefill = 6;
NSInteger const wallQueryLimit = 5;


//APP DELEGATE CONSTS
NSString *const parseAppId = @"tJ6qdBURpjHaQp8O7mgPutIL8tPIhjJyAkn8l0OO";
NSString *const parseAppClient= @"0GNLZ6RMHNjQJfU6GwFp1ZzFhnzJm7mpvukIDQCs";
NSString *const parseServerLink = @"https://parseapi.back4app.com";
NSString *const googleMapsGetKey =  @"GMapsAPIKey";
NSString *const configurationString = @"Default Configuration";
NSString *const appShortcutString =  @"com.abena.Dorm-Room-Wall.viewImage";
NSString *const keysString = @"Keys";
NSString *const plistString = @"plist";



//SCENE DELEGATE CONSTANTS
NSString *const mainString = @"Main";
NSString *const homeTabControllerId = @"HomeTabController";


//WALL CLASS CONSTANTS
NSString *const wallString = @"Wall";
NSString *const imageString = @"image.png";
NSString *const objectIdString = @"objectId";


// WALLCELL CONSTANTS
NSString *const heartFillImageName = @"heart.fill";
NSString *const heartImageName = @"heart";
NSString *const userLikesDictionary = @"usersLikeDictionary";


//GMAPVC CONSTANTS
NSString *const pinString = @"custom_pin.png";
NSString *const markerTitleString = @"Here!";



//LOGINVC CONSTANTS
NSString *const loginSegue = @"loginSegue";
NSString *const alertControllerTitle = @"Empty Field!";
NSString *const alertControllerMessage = @"Provide username or password";
NSString *const cancelString = @"Cancel";
NSString *const okString = @"OK";




//WALLFEEDCONTROLLER CONSTANTS
NSString *const loginControllerId = @"LoginViewController";
NSString *const wallCellId = @"WallCell";
NSString *const wallHeaderViewId = @"WallHeaderView";
NSString *const mapControllerId = @"GMapViewController";
NSString *const postNotification = @"TestNotification";
NSString *const finishedLikeNotification = @"OutOfLikes";
NSString *const wallArrayCached = @"wallArrayCached";
NSString *const hoursSpent = @"Hours spent:";
NSString *const idStringFormat = @"%@";
NSString *const alertRestrictTitle = @"Restricted!";
NSString *const alertRestrictMessage = @"You cannot like your own post!";
NSString *const alertOutOfLikesTitle = @"You are out of likes for now!";
NSString *const alertOutOfLikesAction = @"Wait";
NSInteger const rowCount = 1;




NSString *const squarePencilName = @"square.and.pencil";
NSString *const trashName = @"trash.slash";
NSString *const paperPlaneName = @"paperplane";
NSString *const profileImageName = @"person.circle.fill";




@end
