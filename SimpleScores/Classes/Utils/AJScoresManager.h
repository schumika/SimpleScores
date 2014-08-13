//
//  AJScoresManager.h
//  SimpleScores
//
//  Created by Anca Calugar on 07/07/14.
//
//

#import <Foundation/Foundation.h>

@class AJGame;

@interface AJScoresManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// Games methods
- (NSArray *)getGamesArray;
- (AJGame *)insertGameWithId:(int)gameId atPosition:(int)position;
- (AJGame *)getGameWithId:(int)gameId;
- (void)deleteGameWithId:(int)gameId;
- (void)deleteGame:(AJGame *)game;

@end
