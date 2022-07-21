//
//  WallHeaderView.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/18/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface WallHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerUsername;
@property (strong, nonatomic) PFUser *wallAuthor;

@end

NS_ASSUME_NONNULL_END
