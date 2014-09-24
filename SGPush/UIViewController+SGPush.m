//
//  UIViewController+SGPush.m
//  SGPushDemo
//
//  Created by Sagi on 9/22/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import "UIViewController+SGPush.h"
#import "SGPush.h"
#import <objc/runtime.h>

@implementation UIViewController (SGPush)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSels[2] = {@selector(viewDidAppear:), @selector(viewDidDisappear:)};
        SEL swizzledSels[2] = {@selector(_sgPush_viewDidAppear:), @selector(_sgPush_viewDidDisappear:)};
        
        for (int i=0; i<2; i++) {
            SEL originalSelector = originalSels[i];
            SEL swizzledSelector = swizzledSels[i];
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL didAddMethod = class_addMethod(class,
                                                originalSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(class,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}

- (void)_sgPush_viewDidAppear:(BOOL)animated
{
    [self _sgPush_viewDidAppear:animated];
    
    [self _executePendingPushHandlerIfNeeded];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)_sgPush_viewDidDisappear:(BOOL)animated
{
    [self _sgPush_viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
}

#pragma mark - UIApplication Notification

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self _executePendingPushHandlerIfNeeded];
}

#pragma mark - Handle Remote Push

- (BOOL)canHandleRemotePush:(SGPushHandler *)pushHandler
{
    return YES;
}

- (void)_executePendingPushHandlerIfNeeded
{
    SGPushHandler *pushHandler = [SGPush pendingPushHandler];
    if (pushHandler && [self canHandleRemotePush:pushHandler]) {
        [SGPush executePendingPushHandlerFromViewController:self];
    }
}

@end
