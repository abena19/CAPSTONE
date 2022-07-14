//
//  HeaderCell.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/13/22.
//

#import "HeaderCell.h"

@implementation HeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setHeader:(Wall *)wall {
    self.usernameLabel.text = wall.author.username;
    self.usernameLabel.textColor = [UIColor systemTealColor];
    self.backgroundColor = [UIColor blackColor];
}


@end
