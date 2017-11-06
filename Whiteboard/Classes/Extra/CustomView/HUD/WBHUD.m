//
//  WBHUD.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/5.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBHUD.h"
#import <MBProgressHUD.h>

@implementation WBHUD

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud hideAnimated:YES afterDelay:10];
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (BOOL)hideForView:(UIView *)view{
    return [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (MBProgressHUD *)createCustomHUDFromView:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
    return hud;

}

+ (MBProgressHUD *)showSuccessMessage:(NSString *)message toView:(UIView *)view{
    
    [self hideForView:view];
    
    MBProgressHUD *hud = [self createCustomHUDFromView:view];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_tab_badge_check"]];
    hud.label.text = message;
    return hud;
}
+ (MBProgressHUD *)showErrorMessage:(NSString *)message toView:(UIView *)view{
    [self hideForView:view];

    MBProgressHUD *hud = [self createCustomHUDFromView:view];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_notification_warning"]];
    hud.label.text = message;
    return hud;

}

@end
