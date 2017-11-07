//
//  WBMessageManager.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/7.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBMessageManager.h"

@implementation WBMessageManager
+ (void)createMessageWithContent:(NSString *)content
                    successBlock:(void (^)(void))successBlock
                     failedBlock:(void (^)(NSString *))failedBlock{
    
    
    if (content.lcg_removeWhitespaceAndNewlineCharacterSet.length == 0) {
        if (failedBlock) {
            failedBlock(@"请输入内容.");
        }
        return;
    }
    
    
    AVObject *blackboardMapUser= [[AVObject alloc] initWithClassName:t_Message];// 选课表对象
    // 设置关联
    [blackboardMapUser setObject:content forKey:@"content"];
    [blackboardMapUser setObject:WBUserModel.currentUser forKey:@"createUser"];
    [blackboardMapUser setObject:WBUserModel.currentUser forKey:@"updateUser"];
    [blackboardMapUser setObject:WBUserModel.currentUser.currentBlackboard forKey:@"blackboard"];

    [blackboardMapUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (succeeded) {
            if (successBlock) {
                successBlock();
            }
        }else{
            
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
        
    }];
}


+ (void)lastMessageOfCurrentBoardForSuccessBlock:(void (^)(WBMessageModel *model))successBlock
                                     failedBlock:(void (^)(NSString *message))failedBlock{
    AVQuery *query = [AVQuery queryWithClassName:t_Message];
    [query whereKey:k_Blackboard equalTo:WBUserModel.currentUser.currentBlackboard];
    [query includeKey:@"createUser"];
    [query includeKey:@"updateUser"];
    [query includeKey:k_Blackboard];
    [query addDescendingOrder:k_CreatedAt];
    [query setLimit:1];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (successBlock) {
            successBlock(objects.firstObject);
        }else{
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
        
    }];
    
}

@end
