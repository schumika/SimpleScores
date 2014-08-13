//
//  AJAddNewItemViewController.m
//  SimpleScores
//
//  Created by Anca Calugar on 08/07/14.
//
//

#import "AJAddNewItemViewController.h"
#import "AJItemImageAndNameTableViewCell.h"
#import "AJGameViewModel.h"
#import "AJColorPickerTableViewCell.h"

#define SELECT_PICTURE_ACTION_SHEET_TAG    (1)

static NSString *kAJItemImageAndNameTableViewCell = @"AJItemImageAndNameTableViewCell";
static NSString *kAJColorPickerTableViewCell = @"AJColorPickerTableViewCell";

@interface AJAddNewItemViewController () <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>

@end


@implementation AJAddNewItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.viewModel.viewModelType == AJViewModelGame) {
        self.title = @"Add New Game";
    } else {
        self.title = @"Add New Player";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[(AJItemImageAndNameTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] textField] becomeFirstResponder];
}

#pragma mark - UITableView delegate and datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        AJItemImageAndNameTableViewCell *aCell = (AJItemImageAndNameTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kAJItemImageAndNameTableViewCell];
        if (!aCell) {
            aCell = [[AJItemImageAndNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAJItemImageAndNameTableViewCell];
        }
        
        [self.viewModel updateInfoIntoItemImageAndNameCell:aCell];

        cell = aCell;
    } else if (indexPath.section == 1) {
        AJColorPickerTableViewCell *aCell = (AJColorPickerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kAJColorPickerTableViewCell];
        if (!aCell) {
            aCell = [[AJColorPickerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAJColorPickerTableViewCell];
        }
        
        aCell.colorsArray = @[[UIColor AJPinkColor], [UIColor AJBrightPinkColor], [UIColor AJRedColor], [UIColor AJBrightOrangeColor], [UIColor AJOrangeColor], [UIColor AJYellowColor], [UIColor AJLightGreenColor], [UIColor AJGreenColor], [UIColor AJLightBlueColor], [UIColor AJBlueColor], [UIColor AJDarkBlueColor], [UIColor AJVioletColor], [UIColor AJPurpleColor], [UIColor AJBrownColor]];
        
        cell = aCell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90.0;
    } else if (indexPath.section == 1) {
        return 250.0;
    }
    
    return 0.0;
}

#pragma mark - UITextFieldDelegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
    self.viewModel.name = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Buttons actions
- (IBAction)pictureButton:(UIButton *)sender {
    UIActionSheet *setPictureActionSheet = nil;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        setPictureActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take picture", @"Choose picture", nil];
    } else {
        setPictureActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose picture", nil];
    }
    setPictureActionSheet.tag = SELECT_PICTURE_ACTION_SHEET_TAG;
    [setPictureActionSheet showInView:self.view];
}

- (IBAction)cancelButtonClicked:(id)sender {
    id __autoreleasing myself = self;
    
    if ([self.delegate respondsToSelector:@selector(addNewItemViewControllerDidCancelCreatingViewModel:)]) {
        [self.delegate addNewItemViewControllerDidCancelCreatingViewModel:myself];
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (IBAction)doneButtonClicked:(id)sender {
    id __autoreleasing myself = self;
    
    if ([self.delegate respondsToSelector:@selector(addNewItemViewController:didFinishCreatingViewModel:)]) {
        NSString *name = [(AJItemImageAndNameTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] textField].text;
        UIImage *image = [(AJItemImageAndNameTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] pictureView].image;
        UIColor *color = [(AJColorPickerTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]] selectedColor];
        self.viewModel.name = name ? name : @"<no name>";
        self.viewModel.color = color;
        self.viewModel.colorString = [color toHexString:YES];
        self.viewModel.image = image;
        
        [self.delegate addNewItemViewController:myself didFinishCreatingViewModel:self.viewModel];
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark - UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == SELECT_PICTURE_ACTION_SHEET_TAG) {
        if (buttonIndex != actionSheet.cancelButtonIndex) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.allowsEditing = YES;
            imagePickerController.delegate = self;
            if (buttonIndex == (actionSheet.numberOfButtons - 2)) {
                NSLog(@"choose picture");
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            } else {
                NSLog(@"take picture");
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            
            [self presentViewController:imagePickerController animated:YES completion:NULL];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    AJItemImageAndNameTableViewCell *topCell = (AJItemImageAndNameTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [topCell.pictureView setImage:info[@"UIImagePickerControllerEditedImage"]];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}




@end
