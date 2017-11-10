//
//  WBBoardModel.h
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#import "WBServiceConst.h"

@interface WBBoardModel : AVObject<AVSubclassing>

@property (nonatomic, strong) WBUserModel *createUser;
@property (nonatomic, copy) NSString *coverUrl;
@property (nonatomic, copy) NSString *boardName;


@property (nonatomic, copy) NSString *mapObjID;


@end
