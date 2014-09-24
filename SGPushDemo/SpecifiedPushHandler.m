//
//  SpecifiedPushHandler.m
//  SGPushDemo
//
//  Created by Sagi on 9/24/14.
//  Copyright (c) 2014 AzureLab. All rights reserved.
//

#import "SpecifiedPushHandler.h"

@implementation SpecifiedPushHandler

- (void)executeFromViewController:(UIViewController *)vc
{
    NSString *body = [NSString stringWithFormat:@"%@\ntype = %@",self.info[@"aps"][@"alert"],self.info[@"aps"][@"type"]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Specified Push Handler"
                                                    message:body
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
