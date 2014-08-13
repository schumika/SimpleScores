//
//  AJPlayer+Additions.h
//  SimpleScores
//
//  Created by Anca Calugar on 13/08/14.
//
//

#import "AJPlayer.h"

@interface AJPlayer (Additions)

+ (AJPlayer *)createPlayerWithId:(int)playerId forGame:(AJGame *)game;

@end
