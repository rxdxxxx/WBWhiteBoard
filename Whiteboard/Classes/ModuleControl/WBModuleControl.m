//
//  WBModuleControl.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/5.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBModuleControl.h"
#import "WBLoginController.h"
#import "WBTabBarController.h"

@implementation WBModuleControl
+ (UIViewController *)controllerFromDidFinishLaunching{
    
    return [[WBLoginController alloc] init];
}

+ (UIViewController *)loginedControllerWithUserModel:(AVUser *)userModel{
    return [[WBTabBarController alloc] init];
}

+ (void)exchangeWindowRootControllerWithUserModel:(AVUser *)userModel{
    
    UIViewController *vc = [WBModuleControl loginedControllerWithUserModel:userModel];
    
    [[UIApplication sharedApplication].delegate.window setRootViewController:vc];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}


@end
