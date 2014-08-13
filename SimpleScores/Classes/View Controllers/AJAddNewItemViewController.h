//
//  AJAddNewItemViewController.h
//  SimpleScores
//
//  Created by Anca Calugar on 08/07/14.
//
//

#import <UIKit/UIKit.h>
#import "AJViewModel.h"

@protocol  AJAddNewItemViewControllerDelegate;


@interface AJAddNewItemViewController : UITableViewController

@property (nonatomic, strong) AJViewModel *viewModel;
@property (nonatomic, weak) id<AJAddNewItemViewControllerDelegate> delegate;

@end


@protocol  AJAddNewItemViewControllerDelegate <NSObject>

- (void)addNewItemViewControllerDidCancelCreatingViewModel:(AJAddNewItemViewController *)addNewItemViewController;
- (void)addNewItemViewController:(AJAddNewItemViewController *)addNewItemViewController didFinishCreatingViewModel:(AJViewModel *)viewModel;

@end
