//
//  SGPush.h
//  SGPushDemo
//
//  Created by Sagi on 9/22/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+SGPush.h"
#import "SGPushHandler.h"

@interface SGPush : NSObject

/**
 *  注册SGPushHandler子类并绑定相应的通知类型
 *  构造 SGPushHandler 时会根据 userInfo.keyPath 寻找已注册的对应的子类以初始化。
 *
 *  该方法为含有该 keyPath 的所有推送通知注册统一的 SGPushHandler 子类。
 *
 *  @param handlerClass 实现某种处理逻辑的 SGPushHandler 子类
 *  @param keyPath      能够标示一种推送通知类型的字段（）
 *
 *  @return 是否注册成功
 */
+ (BOOL)registerPushHandlerClass:(Class)handlerClass forKeyPath:(NSString *)keyPath;

/**
 *  注册SGPushHandler子类并绑定相应的通知类型
 *  构造 SGPushHandler 时会根据 userInfo.keyPath 和相应的 value 值，寻找已注册的对应的子类以初始化。
 *
 *  该方法为含有该 keyPath 并且值为 value 的特定推送通知注册相应的 SGPushHandler 子类。
 *
 *  @param handlerClass 实现某种处理逻辑的 SGPushHandler 子类
 *  @param keyPath      能够标示一种推送通知类型的字段
 *  @param value        keyPath 字段的值
 *
 *  @return 是否注册成功
 */
+ (BOOL)registerPushHandlerClass:(Class)handlerClass forKeyPath:(NSString *)keyPath value:(id)value;

/**
 *  接受远程通知消息字典并根据应用当前状态选择立即或延迟处理
 *  1).若应用在前台时接受到远程通知，pushHandler会立即执行，所在视图控制器为window.rootViewController。
 *  2).若应用在后台时接收到远程通知，pushHandler将被暂存，之后每当有UIViewController显示时，均会检查该
 *  UIViewController是否允许执行该推送消息，直到某个VC允许该消息执行时，pushHandler执行处理逻辑，结束后
 *  该pushHandler被销毁。
 *
 *  @param info 远程通知消息字典
 */
+ (void)handleRemotePush:(NSDictionary *)info;

/**
 *  暂存待处理的远程推送通知
 */
+ (SGPushHandler *)pendingPushHandler;

/**
 *  执行暂存的远程推送消息处理逻辑
 *
 *  @param vc 执行时所在的视图控制器
 */
+ (void)executePendingPushHandlerFromViewController:(UIViewController *)vc;

/**
 *  执行远程推送消息处理逻辑
 *
 *  @param pushHandler 远程推送消息处理器
 *  @param vc          执行时所在视图控制器
 */
+ (void)executePushHandler:(SGPushHandler *)pushHandler fromViewController:(UIViewController *)vc;

@end
