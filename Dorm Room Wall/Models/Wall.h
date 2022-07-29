//
//  Wall.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Wall : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *wallID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString* _Nullable caption;
@property (nonatomic, strong) NSString* _Nullable dormAddress;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) PFFileObject *locationImage;
@property (nonatomic, strong) PFFileObject *lectureImage;
@property (nonatomic, strong) PFFileObject *mealImage;
@property (nonatomic, strong) NSMutableDictionary<NSString*, PFUser*>* _Nullable usersLikeDictionary;
@property (nonatomic) BOOL likedByCurrentUser;
+ (Wall *) postWallImage: (NSMutableArray *) imageArray withAddress:( NSString * _Nullable )dormLocation withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
