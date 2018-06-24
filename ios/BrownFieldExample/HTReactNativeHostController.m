//
//  HTReactNativeHostController.m
//  BrownFieldExample
//
//  Created by Harry Tormey on 6/23/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

#import "HTReactNativeHostController.h"

#import <React/RCTRootView.h>
#import <React/RCTLog.h>
#import <React/RCTUIManager.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTBridge.h>

#import "MSREventBridge.h"

@interface HTReactNativeHostController() <MSREventBridgeEventReceiver>

@end

@implementation HTReactNativeHostController


static NSString * const DismissScreenEvent = @"DismissScreen";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    NSURL *jsCodeLocation =  [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"BrownFieldExample"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    self.view = rootView;
}

#pragma make - MSREventBridgeEventReceiver

// Handle events
- (void)onEventWithName:(NSString *)eventName info:(nullable NSDictionary *)info
{
    // Handle events dispatched from React Native
    NSLog(@"Received event: '%@', with info: %@", eventName, info);
    
    // Example for DismissScreen event
    if ([eventName isEqualToString:DismissScreenEvent]) {
        NSLog(@"DismissScreenEvent hit!!");
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }

}

@end
