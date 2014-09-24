//
//  AppDelegate.m
//  SGPushDemo
//
//  Created by Sagi on 9/22/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import "AppDelegate.h"
#import "SGPush.h"
#import "DefaultPushHandler.h"
#import "SpecifiedPushHandler.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    /**
     *  注册并绑定推送处理逻辑
     *
     *  DefaultPushHandler      只绑定了 keyPath = "aps.type" 的情况，没有指定其值
     *                          因此所有含有该 keyPath 字段的推送消息都拥有了这个默认处理方式。
     *  SpecifiedPushHandler    绑定 keyPath = "aps.type" 并且要求其值为 6
     *                          因此在推送消息的 aps.type = 6 时会使用该子类处理推送消息。
     *
     *  可以根据业务需求注册绑定更多自定义子类来灵活处理各种类型的推送消息。
     */
    [SGPush registerPushHandlerClass:[DefaultPushHandler class] forKeyPath:@"aps.type"];
    [SGPush registerPushHandlerClass:[SpecifiedPushHandler class] forKeyPath:@"aps.type" value:@6];

    /**
     *  本 Demo 中为了方便演示，这里伪造了推送消息 JSON 数据，实际使用时完成上方的注册绑定操作后只需在
     *  application:didFinishLaunchingWithOptions: 和 
     *  application:didReceiveRemoteNotification: 
     *  两个方法中调用 SGPush 的 handleRemotePush: 传入 userInfo 即可。
     */
    NSString *fakeApsJson = @"{\"aps\":{\"alert\":\"This is a test message.\",\"type\":6,},}";
    NSData *fakeApsData = [fakeApsJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *fakeApsObj = [NSJSONSerialization JSONObjectWithData:fakeApsData options:NSJSONReadingAllowFragments error:nil];
    [SGPush handleRemotePush:fakeApsObj];
    
    return YES;
}

@end
