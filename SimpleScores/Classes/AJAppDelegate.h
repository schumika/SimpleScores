//
//  AppDelegate.h
//  SimpleScores
//
//  Created by Anca Calugar on 07/07/14.
//
//

#import <UIKit/UIKit.h>
#import "AJScoresManager.h"

@interface AJAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) AJScoresManager *scoresManager;

@end
