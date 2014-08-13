//
//  AJGame.h
//  SimpleScores
//
//  Created by Anca Calugar on 13/08/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AJPlayer;

@interface AJGame : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic) int16_t gameId;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t position;
@property (nonatomic, retain) NSSet *players;
@end

@interface AJGame (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(AJPlayer *)value;
- (void)removePlayersObject:(AJPlayer *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
