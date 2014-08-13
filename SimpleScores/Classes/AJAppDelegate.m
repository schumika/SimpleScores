//
//  AppDelegate.m
//  SimpleScores
//
//  Created by Anca Calugar on 07/07/14.
//
//

#import "AJAppDelegate.h"

#define TEST_POPULATE_DB_WITH_GAMES         0
#define TEST_POPULATE_DB_WITH_PLAYERS       0

@implementation AJAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if TEST_POPULATE_DB_WITH_GAMES == 1
    NSLog(@"gamesArray: %@", [self.scoresManager getGamesArray]);
    
    AJGame *game1 = [self.scoresManager insertGameWithId:0 atPosition:0];
    [self.scoresManager insertGameWithId:1 atPosition:1];
    [self.scoresManager insertGameWithId:2 atPosition:2];
    
    NSLog(@"gamesArray: %@", [self.scoresManager getGamesArray]);
    
    NSLog(@"at application:didFinishLaunchingWithOptions: the games array is: %@", [self.scoresManager getGamesArray]);
#endif
    
#if TEST_POPULATE_DB_WITH_PLAYERS == 1
    NSLog(@"playersArray for game: %@", [self.scoresManager getGamesArray]);
    
    [self.scoresManager insertPlayerWithId:0 forGame:game1];
    [self.scoresManager insertPlayerWithId:1 forGame:game1];
    [self.scoresManager insertPlayerWithId:2 forGame:game1];
    
    NSLog(@"playersArray for game: %@", [self.scoresManager getGamesArray]);
    
    NSLog(@"at application:didFinishLaunchingWithOptions: the playersArray for game is: %@", [self.scoresManager getGamesArray]);
#endif
    
    NSLog(@"at application:didFinishLaunchingWithOptions: the games array contains %d items", [[self.scoresManager getGamesArray] count]);
    
    for (AJGame *game in [self.scoresManager getGamesArray]) {
        NSLog(@"players :%@", [self.scoresManager getPlayersArrayForGame:game]);
    }
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor AJGreenColor],
                                                           NSFontAttributeName : [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:27.0]}];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self.scoresManager saveContext];
}

#pragma mark - Public properties

- (AJScoresManager *)scoresManager {
    if (!_scoresManager) {
        _scoresManager = [[AJScoresManager alloc] init];
    }
    
    return _scoresManager;
}

@end
