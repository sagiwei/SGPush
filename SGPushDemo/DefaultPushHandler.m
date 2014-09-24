//
//  DefaultPushHandler.m
//  SGPushDemo
//
//  Created by Sagi on 9/23/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import "DefaultPushHandler.h"

@implementation DefaultPushHandler

- (void)executeFromViewController:(UIViewController *)vc
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Default Push Handler"
                                                    message:self.info[@"aps"][@"alert"]
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
