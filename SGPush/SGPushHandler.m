//
//  SGPushHandler.m
//  SGPushDemo
//
//  Created by Sagi on 9/22/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import "SGPushHandler.h"

@implementation SGPushHandler

- (instancetype)initWithPushInfo:(NSDictionary *)info applicationState:(UIApplicationState)state
{
    self = [super init];
    if (self) {
        _info = info;
        if (state == UIApplicationStateActive) {
            _isRecivedWhenApplicationInForeground = YES;
        }else {
            _isRecivedWhenApplicationInForeground = NO;
        }
    }
    return self;
}

- (void)executeFromViewController:(UIViewController *)vc
{
    [[NSException exceptionWithName:NSGenericException
                             reason:@"You must implement remote message handle logic in your subclass."
                           userInfo:nil] raise];
}

@end
