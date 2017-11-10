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

/**
 分页拉取,消息内容展示历史记录
 
 @param message 起始的index,0从第一个开始
 @param limit 每一页多少个数据项
 */
+ (void)messageListStartIndexMessage:(WBMessageModel *)message
                               limit:(NSInteger)limit
                        successBlock:(void (^)(NSArray<WBMessageModel *> *dataArray))successBlock
                         failedBlock:(void (^)(NSString *message))failedBlock{
    
    
    
    AVQuery *startDateQuery = [AVQuery queryWithClassName:t_Message];
    
    if (message == nil) {
        [startDateQuery whereKey:@"updatedAt" lessThan:[NSDate date]];
    }else{
        [startDateQuery whereKey:@"updatedAt" lessThan:message.updatedAt];
    }
    
    
    AVQuery *query = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:startDateQuery,nil]];
    [query whereKey:k_Blackboard equalTo:WBUserModel.currentUser.currentBlackboard];
    [query addDescendingOrder:k_UpdatedAt];
    [query setLimit:limit];
    
    [query includeKey:@"createUser"];
    [query includeKey:@"updateUser"];
    [query includeKey:k_Blackboard];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (successBlock) {
            successBlock(objects);
        }else{
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
        
    }];
    
    
}

+ (void)editMessageContentWithString:(NSString *)aNewString
                      changedMessage:(WBMessageModel *)messageModel
                        successBlock:(void (^)(void))successBlock
                         failedBlock:(void (^)(NSString *message))failedBlock{
    
    if (aNewString.lcg_removeWhitespaceAndNewlineCharacterSet.length == 0) {
        if (failedBlock) {
            failedBlock(@"请输入内容.");
        }
        return;
    }
    
    if (messageModel == nil) {
        if (failedBlock) {
            failedBlock(@"这个消息...伦家改不了");
        }
        return;
    }
    
    
    // 修改属性
    [messageModel setObject:aNewString forKey:@"content"];
    //[messageModel setObject:WBUserModel.currentUser forKey:@"updateUser"];
    // 保存到云端
    [messageModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            
            [WBNotificationCenter postNotificationName:kNotificationUserChangeUserName object:nil];
            
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

@end
