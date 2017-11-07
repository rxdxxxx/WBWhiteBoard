//
//  WBUserModel.h
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@class WBBoardModel;

@interface WBUserModel : AVUser

@property (nonatomic, copy) NSString *avatarUrl; ///< 用户头像地址
@property (nonatomic, copy) NSString *nickName; ///< 用户昵称
@property (nonatomic, strong) WBBoardModel *currentBlackboard;

- (NSString *)displayName;

@end
