//
//  HTReactNativeHostController.m
//  BrownFieldExample
//
//  Created by Harry Tormey on 6/23/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

#import "HTReactNativeHostController.h"

#import <React/RCTRootView.h>
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>

#import "MSREventBridge.h"
#import "HTReactNativeEvent.h"

static NSString * const DismissScreenEvent = @"DismissScreen";

@interface HTReactNativeHostController() <MSREventBridgeEventReceiver>

@end

@implementation HTReactNativeHostController {
    NSMutableArray *_events;
    NSString *_screen;
    NSDictionary *_properties;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(![self isMemberOfClass:[HTReactNativeHostController class]], @"initWithCoder not supported");
    return [super initWithCoder:aDecoder];
}

- (id)init {
    NSAssert(![self isMemberOfClass:[HTReactNativeHostController class]], @"Init not supported");
    return [super init];
}

// TODO add asset to stup 
- (id)initWithScreen:(NSString *)screen properties:(NSDictionary *)properties {
    self = [super init];
    if (!self) return nil;
    _screen = screen;
    _properties = properties;
    _events = [NSMutableArray new];
    [self setupReactNativeRootView:properties];

    return self;
}

- (void)setupReactNativeRootView:(NSDictionary *)properties {
    RCTBridge *bridge = [[RCTBridge alloc] initWithBundleURL:[HTReactNativeHostController getJSCodeLocation] moduleProvider:nil launchOptions:nil];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"BrownFieldExample" initialProperties:properties];
    self.view = rootView;
    [self.view layoutIfNeeded];
    // Add test event
    HTReactNativeEvent *event = [[HTReactNativeEvent alloc] initWithName:@"DismissScreen" handler:^(NSDictionary *info){
        NSLog(@"Dismiss events");
        // TODO make this weak to avoid syclic.
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self addEvent:event];
    
    // Delay execution of my block for 7 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"Fire event !!!");
        RCTRootView *test = (RCTRootView *)self.view;
        [[test.bridge viewControllerEventEmitter] emitEventWithName:@"Testing" info:@{}];
//            [[[HTReactNativeHostController bridge] viewControllerEventEmitter] emitEventWithName:name info:info];
//        [HTReactNativeHostController sendEventWithName:@"Testing" info:@{@"boo" : @"ra"}];
    });


}

- (void)addEvent:(HTReactNativeEvent *)event {
    NSLog(@"addEvent called with %@", event);
    if (!event) return;
    [_events addObject:event];
    NSLog(@"Added event %@", _events);
}

- (void)removeEvent:(HTReactNativeEvent *)event {
    if (!event) return;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", event.name];
    _events = [[_events filteredArrayUsingPredicate:predicate] mutableCopy];
}

- (HTReactNativeEvent *)findEventFrom:(NSString *)name {
    if (!name) return nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    return [[_events filteredArrayUsingPredicate:predicate] firstObject];
}

+ (BOOL)inDeveloperMode {
    return false;
}

+ (NSURL *) getJSCodeLocation {
    NSURL *localServer =  [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    // TODO: Add in codepush etc, and pivot on developerMode
    return localServer;
}

+ (void)missingEventWithName:(NSString *)name
{
    
}

/// Warm up the React bridge on app launch
+ (void)applicationLaunched
{
    [HTReactNativeHostController controller];
}

+ (RCTBridge *)bridge {
    static RCTBridge *bridge = nil;
    if (!bridge) {
        bridge = [[RCTBridge alloc] initWithBundleURL:[HTReactNativeHostController getJSCodeLocation] moduleProvider:nil launchOptions:nil];
    }
    return bridge;
}

+ (HTReactNativeHostController *)controller {
    static HTReactNativeHostController *controller = nil;
    if (!controller) {
        // TODO update this
        controller = [[HTReactNativeHostController alloc] initWithScreen:@"query" properties:nil];
    }
    return controller;
}

+ (void)sendEventWithName:(NSString *)name info:(NSDictionary *)info {
NSAssert(!(!name), @"Event name missing");
    [[[HTReactNativeHostController bridge] viewControllerEventEmitter] emitEventWithName:name info:info];
}

#pragma make - MSREventBridgeEventReceiver

// Handle events
- (void)onEventWithName:(NSString *)eventName info:(nullable NSDictionary *)info
{
    // Handle events dispatched from React Native
    NSLog(@"Received event: '%@', with info: %@", eventName, info);
    HTReactNativeEvent *event = [self findEventFrom:eventName];
    NSLog(@"event is %@ ", event);
    NSLog(@"events is %@", _events);
    if (event) {
        NSLog(@"Calling handler");
        event.handler(info);
    }
}

@end
