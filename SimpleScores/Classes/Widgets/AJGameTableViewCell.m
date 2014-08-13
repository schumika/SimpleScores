//
//  AJGameTableViewCell.m
//  SimpleScores
//
//  Created by Anca Calugar on 07/07/14.
//
//

#import "AJGameTableViewCell.h"

@interface AJGameTableViewCell ()

@end


@implementation AJGameTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
