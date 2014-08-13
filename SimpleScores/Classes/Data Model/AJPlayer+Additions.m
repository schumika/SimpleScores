//
//  AJPlayer+Additions.m
//  SimpleScores
//
//  Created by Anca Calugar on 13/08/14.
//
//

#import "AJPlayer+Additions.h"
#import "AJGame+Additions.h"

@implementation AJPlayer (Additions)

+ (AJPlayer *)createPlayerWithId:(int)playerId forGame:(AJGame *)game {
    AJPlayer *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:game.managedObjectContext];
    player.playerId = playerId;
    player.name = @"<No Name>";
    player.color = [[UIColor AJBrownColor] toHexString:YES];
    player.imageData = nil;
    player.game = game;
    
    return player;
}


@end
