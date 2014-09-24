//
//  UIViewController+SGPush.h
//  SGPushDemo
//
//  Created by Sagi on 9/22/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGPushHandler;

@interface UIViewController (SGPush)

/**
 *  是否能够处理某个推送消息
 *
 *  @param pushHandler 远程推送处理器
 *
 *  @return 返回yes，pushHandler将会执行。返回no，pushHandler继续暂存等待执行。
 */
- (BOOL)canHandleRemotePush:(SGPushHandler *)pushHandler;

@end
