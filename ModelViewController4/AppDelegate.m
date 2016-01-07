//
//  AppDelegate.m
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/24/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UITabBarController* tabBarController = (UITabBarController*) self.window.rootViewController;
    ((UITabBarItem*)tabBarController.tabBar.items[0]).selectedImage = [UIImage imageNamed:@"Album"];
    ((UITabBarItem*)tabBarController.tabBar.items[1]).selectedImage = [UIImage imageNamed:@"Music"];
    
    DataManager* dataManager = [DataManager getSingleton];
    return YES;
}



@end
