//
//  Constants.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 8/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Constants : NSObject

//PARSE CONSTS

extern NSString *const usersLikeDictionary;
extern NSString *const userLikesLeft;
extern NSString *const likeCountLimit;
extern NSString *const timeSinceFirstLike;
extern NSString *const userWallCount;
extern NSString *const createdAt;
extern NSString *const author;
extern NSString *const outOfLikes;
extern NSString *const dateStringFormat;
extern NSString *const emptyString;
extern NSString *const doubleFormat;



//APP DELEGATE CONSTANTS
extern NSString *const parseAppId;
extern NSString *const parseAppClient;
extern NSString *const parseServerLink;
extern NSString *const googleMapsGetKey;
extern NSString *const configurationString;
extern NSString *const appShortcutString;
extern NSString *const keysString;
extern NSString *const plistString;




//SCENE DELEGATE CONSTANTS
extern NSString *const mainString;
extern NSString *const homeTabControllerId;




//WALL CLASS CONSTANTS
extern NSString *const wallString;
extern NSString *const imageString;




// WALLCELL CONSTANTS
extern NSString *const heartFillImageName;
extern NSString *const heartImageName;
extern NSString *const userLikesDictionary;


//GMAPVC CONSTANTS
extern NSString *const pinString;
extern NSString *const markerTitleString;



// COMPOSEVC CONSTANTS
typedef NS_ENUM(NSInteger , tapWallEditHandlerState) {
    DefaultState = 0,
    MealPhoto = 1,
    LocationPhoto = 2,
    LecturePhoto =3,
};




//LOGINVC CONSTANTS
extern NSString *const loginSegue;
extern NSString *const alertControllerTitle;
extern NSString *const alertControllerMessage;
extern NSString *const cancelString;
extern NSString *const okString;



//WALLFEEDCONTROLLER CONSTANTS
extern NSString *const loginControllerId;
extern NSString *const wallCellId;
extern NSString *const wallHeaderViewId;
extern NSString *const mapControllerId;
extern NSString *const postNotification;
extern NSString *const finishedLikeNotification;
extern NSString *const wallArrayCached;
extern NSString *const hoursSpent;
extern NSString *const idStringFormat;
extern NSString *const alertRestrictTitle;
extern NSString *const alertRestrictMessage;
extern NSString *const alertOutOfLikesTitle;
extern NSString *const alertOutOfLikesAction;
extern NSInteger const rowCount;




extern NSString *const squarePencilName;
extern NSString *const trashName;
extern NSString *const paperPlaneName;
extern NSString *const profileImageName;



@end

NS_ASSUME_NONNULL_END
