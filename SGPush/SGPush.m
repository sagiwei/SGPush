//
//  SGPush.m
//  SGPushDemo
//
//  Created by Sagi on 9/22/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import "SGPush.h"

@interface SGPush ()
@property (nonatomic, strong) SGPushHandler *pendingPushHandler;
@property (nonatomic, strong) NSMutableDictionary *handlerMapping;
@end

@implementation SGPush

+ (instancetype)sharedPush
{
    static SGPush *_push = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _push = [[SGPush alloc] init];
    });
    return _push;
}

+ (BOOL)registerPushHandlerClass:(Class)handlerClass forKeyPath:(NSString *)keyPath
{
    return [SGPush registerPushHandlerClass:handlerClass forKeyPath:keyPath value:[NSNull null]];
}

+ (BOOL)registerPushHandlerClass:(Class)handlerClass forKeyPath:(NSString *)keyPath value:(id)value
{
    if ([[handlerClass new] isKindOfClass:[SGPushHandler class]] && keyPath != nil && value != nil) {
        NSDictionary *valueDict = @{keyPath: [value description]};
        NSString *keyString = NSStringFromClass(handlerClass);
        SGPush *push = [SGPush sharedPush];
        if (![push.handlerMapping objectForKey:keyString]) {
            [push.handlerMapping setObject:[NSMutableSet set] forKey:keyString];
        }
        NSMutableSet *set = [push.handlerMapping objectForKey:keyString];
        [set addObject:valueDict];
        
        return YES;
    }
    
    return NO;
}

+ (void)handleRemotePush:(NSDictionary *)info
{
    if (info == nil) {
        return;
    }
    
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    
    SGPush *push = [SGPush sharedPush];
    Class handlerClass = [push _handlerClassForPushInfo:info];
    handlerClass = handlerClass ? handlerClass : [SGPushHandler class];
    SGPushHandler *pushHandler = [[handlerClass alloc] initWithPushInfo:info applicationState:state];
    
    if (pushHandler.isRecivedWhenApplicationInForeground) {
        id rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [pushHandler executeFromViewController:rootVc];
    }else {
        push.pendingPushHandler = pushHandler;
    }
}

+ (void)executePendingPushHandlerFromViewController:(UIViewController *)vc
{
    [[SGPush sharedPush] _executePendingPushHandlerFromViewController:vc];
}

+ (void)executePushHandler:(SGPushHandler *)pushHandler fromViewController:(UIViewController *)vc
{
    [[SGPush sharedPush] _executePushHandler:pushHandler fromViewController:vc];
}

+ (SGPushHandler *)pendingPushHandler
{
    return [SGPush sharedPush].pendingPushHandler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _handlerMapping = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)_executePendingPushHandlerFromViewController:(UIViewController *)vc
{
    if (self.pendingPushHandler == nil) {
        return;
    }
    
    [self _executePushHandler:self.pendingPushHandler fromViewController:vc];
    self.pendingPushHandler = nil;
}

- (void)_executePushHandler:(SGPushHandler *)pushHandler fromViewController:(UIViewController *)vc
{
    [pushHandler executeFromViewController:vc];
}

- (Class)_handlerClassForPushInfo:(NSDictionary *)info
{
    __block NSString *specifiedClassName = nil;
    __block NSString *generalClassName = nil;
    [self.handlerMapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        for (NSDictionary *dict in (NSArray *)obj) {
            NSString *keyPah = [dict allKeys].firstObject;
            NSString *valueString = dict[keyPah];
            if ([info valueForKeyPath:keyPah] && [valueString isEqualToString:[[NSNull null] description]]) {
                generalClassName = key;
            }
            if ([[[info valueForKeyPath:keyPah] description] isEqualToString:valueString]) {
                specifiedClassName = key;
                *stop = YES;
            }
        }
    }];
    
    NSString *className = nil;
    if (specifiedClassName) {
        className = specifiedClassName;
    }else if (generalClassName) {
        className = generalClassName;
    }
    
    return NSClassFromString(className);
}

@end
