//
//  AJViewModel.h
//  SimpleScores
//
//  Created by Anca Calugar on 08/07/14.
//
//

#import <Foundation/Foundation.h>

@class AJItemImageAndNameTableViewCell;

typedef enum {
    AJViewModelGame,
    AJViewModelPlayer
} AJViewModelType;

@interface AJViewModel : NSObject

@property (nonatomic, assign) AJViewModelType viewModelType;

@property (nonatomic, assign)           int position;
@property (nonatomic, assign, readonly) int itemId;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *colorString;
@property (nonatomic, strong) NSData   *imageData;

+ (AJViewModel *)viewModelWithType:(AJViewModelType)viewModelType;

- (void)updateInfoIntoItemImageAndNameCell:(AJItemImageAndNameTableViewCell *)itemCell;

@end
