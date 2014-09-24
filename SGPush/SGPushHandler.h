//
//  SGPushHandler.h
//  SGPushDemo
//
//  Created by Sagi on 9/22/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SGPushHandler : NSObject

/**
 *  远程推送消息字典
 */
@property (nonatomic, copy) NSDictionary *info;

/**
 *  接受该远程推送时应用是否在前台
 */
@property (nonatomic, assign) BOOL isRecivedWhenApplicationInForeground;

/**
 *  构造推送消息处理器
 *
 *  @param info  远程推送消息的 userInfo
 *  @param state 接受到远程推送时刻应用的状态
 *
 *  @return 远程推送消息处理器实例
 */
- (instancetype)initWithPushInfo:(NSDictionary *)info applicationState:(UIApplicationState)state;

/**
 *  执行远程推送通知的处理逻辑
 *  该方法必须由子类重载实现，具体实现逻辑可以按需求灵活控制
 *
 *  @param vc 执行时所在视图控制器
 */
- (void)executeFromViewController:(UIViewController *)vc;

@end
