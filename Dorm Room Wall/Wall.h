//
//  Wall.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Wall : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *wallID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *locationImage;
@property (nonatomic, strong) PFFileObject *lectureImage;
@property (nonatomic, strong) PFFileObject *mealImage;

+ (Wall*) postWallImage: (NSMutableArray *) imageArray withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
