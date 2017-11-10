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

#pragma mark - Subclass Methods
#pragma mark - Public Methods

+ (void)changeUserHeaderWithImage:(UIImage *)image
                     successBlock:(void(^)(void))successBlock
                      failedBlock:(void(^)(NSString *message))failedBlock{
    
    NSData *data = [UITools compressOriginalImage:image toMaxDataSizeKBytes:50];
    
    AVFile *file = [AVFile fileWithData:data];
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // 成功或失败处理...
        if (succeeded) {
            [self changeUserHeader:file successBlock:successBlock failedBlock:failedBlock];
        }else{
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
    }];
}


+ (void)changeUserHeader:(AVFile *)file
                 successBlock:(void(^)(void))successBlock
                  failedBlock:(void(^)(NSString *message))failedBlock{
    
    WBUserModel *user = [WBUserModel currentUser];
    
    // 修改属性
    [user setObject:file.url forKey:@"avatarUrl"];
    // 保存到云端
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            
            [WBNotificationCenter postNotificationName:kNotificationUserChangeHeaderImage object:nil];
            
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

+ (void)changeUserNicknameWithString:(NSString *)nameString
                        successBlock:(void (^)(void))successBlock
                         failedBlock:(void (^)(NSString *))failedBlock{
    
    if (nameString == nil || nameString.length == 0) {
        if (failedBlock) {
            failedBlock(@"再给自己其他其他昵称吧");
        }
        return;
    }
    
    
    WBUserModel *user = [WBUserModel currentUser];
    // 修改属性
    [user setObject:nameString forKey:@"nickName"];
    // 保存到云端
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
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
