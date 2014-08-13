//
//  AJScoresManager.m
//  SimpleScores
//
//  Created by Anca Calugar on 07/07/14.
//
//

#import "AJScoresManager.h"

#import "AJGame+Additions.h"
#import "AJplayer+Additions.h"

@implementation AJScoresManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SimpleScores" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SimpleScores.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Public methods

// Game methods
- (NSArray *)getGamesArray {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Game"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"position" ascending:NO]];
    
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

- (AJGame *)insertGameWithId:(int)gameId atPosition:(int)position {
    AJGame *game = [AJGame createGameWithId:gameId inManagedObjectContext:self.managedObjectContext];
    game.position = position;
    
    [self saveContext];
    
    return game;
}

- (AJGame *)getGameWithId:(int)gameId {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Game"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"gameId = %d", gameId];
    fetchRequest.predicate = predicate;
    
    return [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
}

- (void)deleteGameWithId:(int)gameId {
    [self deleteGame:[self getGameWithId:gameId]];
}

- (void)deleteGame:(AJGame *)game {
    [[self managedObjectContext] deleteObject:game];
    
    [self saveContext];
}

- (void)deleteAllGames {
    for (AJGame *game in [self getGamesArray]) {
        [self deleteGame:game];
    }
}

// Player methods
- (NSArray *)getPlayersArrayForGame:(AJGame *)game {
    return [game.players allObjects];
}

- (AJPlayer *)insertPlayerWithId:(int)playerId forGame:(AJGame *)game {
    AJPlayer *player = [AJPlayer createPlayerWithId:playerId forGame:game];
    [self saveContext];
    
    return player;
}

@end
