//
//  WBMessageModel.h
//  Whiteboard
//
//  Created by RedRain on 2017/11/7.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface WBMessageModel : AVObject

@property (nonatomic, copy) NSString *content; ///< 消息内容
@property (nonatomic, strong) NSNumber *state; ///< 0: 正常 1:删除
@property (nonatomic, strong) WBUserModel *createUser; ///< 创建人
@property (nonatomic, strong) WBUserModel *updateUser; ///< 修改人
@property (nonatomic, strong) WBBoardModel *blackboard; ///< 修改人

@end
