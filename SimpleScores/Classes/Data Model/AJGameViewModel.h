//
//  AJGameViewModel.h
//  SimpleScores
//
//  Created by Anca Calugar on 08/07/14.
//
//

#import <Foundation/Foundation.h>
#import "AJViewModel.h"

@class AJGame;
@class AJGameTableViewCell;


@interface AJGameViewModel : AJViewModel

+ (AJGameViewModel *)gameViewModelForGame:(AJGame *)game;
+ (AJGameViewModel *)gameViewModel;

- (void)updateGameInfoIntoGameCell:(AJGameTableViewCell *)gameCell;

@end
