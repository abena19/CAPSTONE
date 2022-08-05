//
//  Protocols.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 8/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol Likeable

- (void) likeObjectWithCompletion:(void (^)(BOOL succeeded, NSError *error))completion;
- (BOOL) canLikeObject;

@end



@interface Protocols : NSObject

@end

NS_ASSUME_NONNULL_END
