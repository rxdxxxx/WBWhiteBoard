//
//  WBUserModel.h
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>


#define kNotificationUserChangeHeaderImage @"kNotificationUserChangeHeaderImage"
#define kNotificationUserChangeUserName @"kNotificationUserChangeUserName"


@class WBBoardModel;

@interface WBUserModel : AVUser

@property (nonatomic, copy) NSString *avatarUrl; ///< 用户头像地址
@property (nonatomic, copy) NSString *nickName; ///< 用户昵称
@property (nonatomic, strong) WBBoardModel *currentBlackboard;

- (NSString *)displayName;



/**
 修改当前用户的头像

 @param image 头像图片
 */
+ (void)changeUserHeaderWithImage:(UIImage *)image
                     successBlock:(void(^)(void))successBlock
                      failedBlock:(void(^)(NSString *message))failedBlock;

/**
 修改当前用户的昵称
 
 @param nameString 新的昵称
 */
+ (void)changeUserNicknameWithString:(NSString *)nameString
                     successBlock:(void(^)(void))successBlock
                      failedBlock:(void(^)(NSString *message))failedBlock;
@end
