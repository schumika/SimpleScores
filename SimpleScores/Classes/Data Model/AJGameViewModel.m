//
//  AJGameViewModel.m
//  SimpleScores
//
//  Created by Anca Calugar on 08/07/14.
//
//

#import "AJGameViewModel.h"
#import "AJGame.h"

#import "AJGameTableViewCell.h"
#import "AJItemImageAndNameTableViewCell.h"

@interface AJGameViewModel ()

@property (nonatomic, strong) AJGame *game;

@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, strong) NSString *gameColorString;
@property (nonatomic, strong) UIImage *gameImage;

@property (nonatomic, strong) NSData  *gameImageData;
@property (nonatomic, strong) UIColor *gameColor;

@end


@implementation AJGameViewModel

- (id)initWithGame:(AJGame *)game {
    self = [super init];
    if (!self) return nil;
    
    self.game = game;
    self.viewModelType = AJViewModelGame;
    
    self.gameName = self.game.name;
    self.gameImage = [UIImage imageWithData:self.game.imageData];
    self.gameColor = [UIColor colorWithHexString:self.game.color];
    self.gameColorString = self.game.color;
    
    return self;
}

+ (AJGameViewModel *)gameViewModelForGame:(AJGame *)game {
    return [[self alloc] initWithGame:game];
}

+ (AJGameViewModel *)gameViewModel {
    return (AJGameViewModel *)[AJViewModel viewModelWithType:AJViewModelGame];
}

#pragma mark - Overridden from base class

- (NSString *)name {
    return self.gameName;
}

- (void)setName:(NSString *)name {
    self.gameName = name;
}

- (UIColor *)color {
    return self.gameColor;
}

- (void)setColor:(UIColor *)color {
    self.gameColor = color;
}

- (UIImage *)image {
    return self.gameImage;
}

- (void)setImage:(UIImage *)image {
    self.gameImage = image;
}

- (NSString *)colorString {
    return [self.gameColor toHexString:YES];
}

- (void)setColorString:(NSString *)colorString {
    self.gameColorString = colorString;
    self.gameColor = [UIColor colorWithHexString:colorString];
}

- (int)position {
    return self.game.position;
}

- (void)setPosition:(int)position {
    self.game.position = position;
}

- (int)itemId {
    return self.game.gameId;
}

- (NSData *)imageData {
    return UIImagePNGRepresentation(self.gameImage);
}

- (void)setImageData:(NSData *)imageData {
    self.gameImageData = imageData;
    self.gameImage = [UIImage imageWithData:imageData];
}


#pragma mark - Public methods

- (void)updateGameInfoIntoGameCell:(AJGameTableViewCell *)gameCell {
    gameCell.gameNameLabel.text = self.gameName;
    gameCell.gameNameLabel.textColor = self.gameColor;
    if (self.gameImage) {
        gameCell.gamePictureView.image = self.gameImage;
    }
}

@end
