//
//  AJPlayerTableViewCell.h
//  SimpleScores
//
//  Created by Anca Calugar on 13/08/14.
//
//

#import <UIKit/UIKit.h>

@interface AJPlayerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *playerPictureView;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;

@end
