//
//  Wall.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "Constants.h"
#import "ParseQueryManager.h"
#import "Protocols.h"


NS_ASSUME_NONNULL_BEGIN


@interface Wall : PFObject<PFSubclassing, Likeable>

@property (nonatomic, strong) NSString *wallID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString* _Nullable caption;
@property (nonatomic, strong) NSString* _Nullable dormAddress;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) PFFileObject *locationImage;
@property (nonatomic, strong) PFFileObject *lectureImage;
@property (nonatomic, strong) PFFileObject *mealImage;
@property (nonatomic, strong) NSMutableDictionary<NSString*,  NSString* >* _Nullable usersLikeDictionary;
+ (Wall *) postWallImage: (NSMutableArray *) imageArray withAddress:( NSString * _Nullable )dormLocation withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
