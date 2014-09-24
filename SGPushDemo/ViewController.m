//
//  ViewController.m
//  SGPushDemo
//
//  Created by Sagi on 9/22/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+SGPush.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  是否允许在该视图控制器内处理暂存的远程推送消息
 *  返回 yes，将会立即执行 pushHandler 的处理逻辑
 *  返回 no，pushHandler 继续暂存，等待执行。
 *
 *  通过这个方法可以实现路径跳转的功能
 *  例如点击一条消息推送开启应用，首页返回 no 并加载消息详情页面。消息详情页返回 yes 并执行推送逻辑。
 *
 *  @param pushHandler 推送消息处理器
 *
 *  @return
 */
- (BOOL)canHandleRemotePush:(SGPushHandler *)pushHandler
{
    return YES;
}

@end
