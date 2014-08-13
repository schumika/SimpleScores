//
//  AJGame.h
//  SimpleScores
//
//  Created by Anca Calugar on 07/07/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AJGame : NSManagedObject

@property (nonatomic) int16_t gameId;
@property (nonatomic) int16_t position;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSData * imageData;

@end
