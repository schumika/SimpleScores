//
//  AJPlayer.h
//  SimpleScores
//
//  Created by Anca Calugar on 13/08/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AJGame;

@interface AJPlayer : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic) int16_t playerId;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) AJGame *game;

@end
