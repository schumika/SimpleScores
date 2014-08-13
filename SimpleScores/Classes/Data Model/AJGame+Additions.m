//
//  AJGame+Additions.m
//  SimpleScores
//
//  Created by Anca Calugar on 07/07/14.
//
//

#import "AJGame+Additions.h"

@implementation AJGame (Additions)

+ (AJGame *)createGameWithId:(int)gameId inManagedObjectContext:(NSManagedObjectContext *)context {
    AJGame *game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:context];
    game.gameId = gameId;
    game.position = 0;
    game.name = @"<No Name>";
    game.color = [[UIColor AJBrownColor] toHexString:YES];
    game.imageData = nil;
    
    return game;
}

@end
