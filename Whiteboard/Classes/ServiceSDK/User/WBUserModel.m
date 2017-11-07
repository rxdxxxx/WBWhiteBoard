//
//  WBUserModel.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBUserModel.h"

@implementation WBUserModel

- (NSString *)displayName{
    if (self.nickName.length) {
        return self.nickName;
    }else{
        return self.username;
    }
}
@end
