//
//  AJPlayerTableViewController.m
//  SimpleScores
//
//  Created by Anca Calugar on 13/08/14.
//
//

#import "AJPlayersTableViewController.h"

#import "AJPlayerTableViewCell.h"
#import "AJScoresManager.h"
#import "AJGame+Additions.h"

#import "AJAppDelegate.h"

@interface AJPlayersTableViewController ()

@property (nonatomic, strong) NSArray *playerViewModelsArray;
@property (nonatomic, strong) AJScoresManager *scoresManager;

- (void)loadPlayerViewModels;


@end

@implementation AJPlayersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scoresManager = [(AJAppDelegate *)[[UIApplication sharedApplication] delegate] scoresManager];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadPlayerViewModels];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.scoresManager getPlayersArrayForGame:self.game] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *playerCellIdentifier = @"PlayerTableViewCell";
    AJPlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:playerCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[AJPlayerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:playerCellIdentifier];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark - Private methods

- (void)loadPlayerViewModels {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
