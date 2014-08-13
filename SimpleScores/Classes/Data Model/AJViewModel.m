//
//  AJViewModel.m
//  SimpleScores
//
//  Created by Anca Calugar on 08/07/14.
//
//

#import "AJViewModel.h"
#import "AJItemImageAndNameTableViewCell.h"


@implementation AJViewModel

- (id)initWithType:(AJViewModelType)viewModelType {
    self = [super init];
    if (!self) return nil;
    
    self.viewModelType = viewModelType;
    
    return self;
}

+ (AJViewModel *)viewModelWithType:(AJViewModelType)viewModelType {
    return [[self alloc] initWithType:viewModelType];
}

- (void)updateInfoIntoItemImageAndNameCell:(AJItemImageAndNameTableViewCell *)itemCell {
    itemCell.textField.text = self.name;
}

@end
