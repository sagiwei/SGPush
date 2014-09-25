SGPush
=========

>为更好的处理远程推送提供一种可能

=======

###介绍
SGPush 将处理远程推送时所需的头文件引用、逻辑代码封装到 SGPushHandler 的子类中，当点击远程推送消息打开应用或应用开启状态下接收到远程推送消息时自动执行相应的处理逻辑。

###结构
|类|描述|
|-|-|
|`SGPush`|核心类，管理注册的`SGPushHandler`子类，接管系统接收到的远程推送消息|
|`SGPushHandler`|推送数据以及相应处理逻辑的封装类，请根据具体业务需求创建不同的子类并在 `executeFromViewController:` 方法中实现推送处理逻辑，该类本身不可直接使用。
|`UIViewController+SGPush`|提供`canHandleRemotePush:`方法，不同的视图控制器可根据需求选择处理或不处理推送消息|

###使用

####创建 SGPushHandler 子类
每一个子类实现一种远程推送类型的处理逻辑，在子类中重载 `executeFromViewController:` 方法实现推送处理逻辑。

这里我们假定实现了 `MessagePushHandler` 子类来处理用户的消息提醒，`DefaultPushHandler` 子类来为所有其他类型的推送提供默认处理。

####将子类注册到 SGPush 中
想要实现的子类发挥作用需要将它注册到 SGPush 中并与接收到的推送字典 userInfo 中的特定字段和值做绑定。这样当接收到的推送消息含有特定的字段或值时，SGPush 会调用执行相应的 SGPushHandler 子类处理逻辑。  

在 `application:didFinishLaunchingWithOptions:` 方法中进行子类注册：  
```objective-c
[SGPush registerPushHandlerClass:[MessagePushHandler class] forKeyPath:@"aps.messageId"];
[SGPush registerPushHandlerClass:[DefaultPushHandler class] forKeyPath:@"aps"];
```
####接管系统接收到的远程推送
在 `application:didFinishLaunchingWithOptions:` 方法中加入代码：   
```objective-c
[SGPush handleRemotePush:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
```  
iOS7 以下的系统在 `application:didReceiveRemoteNotification:fetchCompletionHandler:` 方法中加入如代码：
```objective-c
[SGPush handleRemotePush:userInfo];
```   
iOS7 以上的系统则在 `application:didReceiveRemoteNotification:fetchCompletionHandler:` 方法中加入代码：
```objective-c
[SGPush handleRemotePush:userInfo];
```  
####测试
通过以上几部，当服务器向设备发送的推送内容 `{"aps":{"alert":"This is a test message.","messageId":100,},}` 时，SGPush 会创建 MessagePushHandler 对象并执行。若推送内容中没有 messageId 字段时，SGPush 会创建 DefaultPushHandler 对象执行推送处理逻辑。

###更多
通过 SGPush 还可以实现更多灵活的推送处理方式，请参考 Demo 中的注释和 SGPush 源码注释。
