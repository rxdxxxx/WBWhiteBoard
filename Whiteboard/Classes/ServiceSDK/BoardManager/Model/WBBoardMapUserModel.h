//
//  WBBoardMapUserModel.h
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface WBBoardMapUserModel : AVObject <AVSubclassing>

@property (nonatomic, strong) WBUserModel *user;
@property (nonatomic, strong) WBBoardModel *blackboard;

@end
