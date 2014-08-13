//
//  AJGamesTableViewController.m
//  SimpleScores
//
//  Created by Anca Calugar on 07/07/14.
//
//

#import "AJGamesTableViewController.h"
#import "AJGameTableViewCell.h"
#import "AJAppDelegate.h"
#import "AJGame+Additions.h"
#import "AJGameViewModel.h"
#import "AJAddNewItemViewController.h"
#import "AJPlayersTableViewController.h"

@interface AJGamesTableViewController () <AJAddNewItemViewControllerDelegate>

@property (nonatomic, strong) NSArray *gameViewModelsArray;
@property (nonatomic, strong) AJScoresManager *scoresManager;

- (void)loadGameViewModels;

@end


@implementation AJGamesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.scoresManager = [(AJAppDelegate *)[[UIApplication sharedApplication] delegate] scoresManager];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadGameViewModels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    [self.scoresManager saveContext];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addNewGame"]) {
        if ([[(UINavigationController *)segue.destinationViewController topViewController] isKindOfClass:[AJAddNewItemViewController class]]) {
            AJAddNewItemViewController *controller = (AJAddNewItemViewController *)[(UINavigationController *)segue.destinationViewController topViewController];
            controller.viewModel = [AJGameViewModel gameViewModel];
            controller.delegate = self;
        }
    } if ([segue.identifier isEqualToString:@"players"]) {
        if ([(UINavigationController *)segue.destinationViewController isKindOfClass:[AJPlayersTableViewController class]]) {
            AJPlayersTableViewController *controller = (AJPlayersTableViewController *)(UINavigationController *)segue.destinationViewController;
            int rowIndex = [self.tableView indexPathForCell:(AJGameTableViewCell *)sender].row;
            controller.game = [self.scoresManager getGameWithId:[(AJGameViewModel *)self.gameViewModelsArray[rowIndex] itemId]];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.gameViewModelsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AJGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameTableViewCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[AJGameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GameTableViewCell"];
    }
    
    [(AJGameViewModel *)self.gameViewModelsArray[indexPath.row] updateGameInfoIntoGameCell:cell];
    
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.editing == UITableViewCellEditingStyleDelete) {
        [self deleteGameFromCellWithIndexPath:indexPath];
    }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:self.gameViewModelsArray];
    AJGameViewModel *gameToMove = mutableArray[fromIndexPath.row];
    [mutableArray removeObjectAtIndex:fromIndexPath.row];
    [mutableArray insertObject:gameToMove atIndex:toIndexPath.row];
    [self setGameViewModelsArray:mutableArray];
    
    [self updateRowIdsForGames];
    [self updateUIAndLoadTableData:YES];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Buttons actions

- (IBAction)editButtonClicked:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleBordered];
    } else {
        [self.tableView setEditing:YES animated:YES];
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
}

#pragma mark - AJAddNewItemViewControllerDelegate methods

- (void)addNewItemViewControllerDidCancelCreatingViewModel:(AJAddNewItemViewController *)addNewItemViewController{
    [addNewItemViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addNewItemViewController:(AJAddNewItemViewController *)addNewItemViewController didFinishCreatingViewModel:(AJGameViewModel *)viewModel {
    [addNewItemViewController dismissViewControllerAnimated:YES completion:NULL];
    
    AJGame *game = [self.scoresManager insertGameWithId:[self.gameViewModelsArray count] atPosition:[self.gameViewModelsArray count]];
    game.name = viewModel.name;
    game.color = viewModel.colorString;
#warning - this needs refactoring!!!!!!!!
    game.imageData = /*viewModel.imageData*/UIImagePNGRepresentation(viewModel.image);
    [self.scoresManager saveContext];
    
    [self loadGameViewModels];
    [self.tableView reloadData];
}

#pragma mark - Private methods

- (void)loadGameViewModels {
    NSMutableArray *array = [NSMutableArray array];
    for (AJGame *game in [self.scoresManager getGamesArray]) {
        AJGameViewModel *gameViewModel = [AJGameViewModel gameViewModelForGame:game];
        [array addObject:gameViewModel];
    }
    
    self.gameViewModelsArray = array;
}


- (void)updateUIAndLoadTableData:(BOOL)loadData {
    [self loadGameViewModels];
    
    if (loadData) {
        [self.tableView reloadData];
    }
}

- (void)updateRowIdsForGames {
    int numberOfGames = [self.gameViewModelsArray count];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (AJGameViewModel *gameViewModel in self.gameViewModelsArray) {
        gameViewModel.position = numberOfGames - [self.gameViewModelsArray indexOfObject:gameViewModel];
        [mutableArray addObject:gameViewModel];
    }
    self.gameViewModelsArray = mutableArray;
    
    [self.scoresManager saveContext];
}

- (void)deleteGameFromCellWithIndexPath:(NSIndexPath*)indexPath {
    [self.tableView beginUpdates];
    [self.scoresManager deleteGameWithId:[(AJGameViewModel *)self.gameViewModelsArray[indexPath.row] itemId]];
    [self updateUIAndLoadTableData:NO];
    [self updateRowIdsForGames];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
    
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}


@end
