//
//  AJGame+Additions.h
//  SimpleScores
//
//  Created by Anca Calugar on 07/07/14.
//
//

#import "AJGame.h"

@interface AJGame (Additions)

+ (AJGame *)createGameWithId:(int)gameId inManagedObjectContext:(NSManagedObjectContext *)context;

@end
