//
//  AJColorPickerTableViewCell.m
//  SimpleScores
//
//  Created by Anca Calugar on 08/07/14.
//
//

#import "AJColorPickerTableViewCell.h"

@interface AJColorPickerTableViewCell() <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end


@implementation AJColorPickerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)dealloc {
    _pickerView.delegate = nil;
    _pickerView.dataSource = nil;
}

- (void)awakeFromNib {
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

- (void)setColorsArray:(NSArray *)colorsArray {
    _colorsArray = colorsArray;
    
    int selectedColorIndex = 3;
    
    if (self.selectedColor) {
        int colorIndex = [self.colorsArray indexOfObject:self.selectedColor];
        selectedColorIndex = (colorIndex == NSNotFound) ? 0 : colorIndex;
    }
    
    self.selectedColor = (UIColor *)self.colorsArray[selectedColorIndex];
    [self.pickerView selectRow:selectedColorIndex inComponent:0 animated:NO];
    
    [self.pickerView reloadAllComponents];
}

#pragma mark - UIPickerViewDelegate and datasource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.colorsArray count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIView *coloredRectangle = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 50.0)];
    
    coloredRectangle.backgroundColor = (UIColor *)self.colorsArray[row];
    
    return coloredRectangle;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedColor = (UIColor *)self.colorsArray[row];
}


@end
