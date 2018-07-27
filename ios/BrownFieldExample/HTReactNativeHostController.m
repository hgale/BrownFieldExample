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

static NSString * const kBundleURL =  @"http://localhost:8081/index.bundle?platform=ios";
static NSString * const kPredicateFormat = @"name == %@";

static BOOL kDevloperMode = false;

@interface MSREventBridgeBridgeManager : NSObject

+ (instancetype)sharedInstance;

@property (readonly) RCTBridge *bridge;

- (RCTRootView *)viewForModuleName:(NSString *)moduleName initialProperties:(NSDictionary *)initialProps;

@end

// TODO move this into common file
@implementation MSREventBridgeBridgeManager

#pragma mark Lifecycle

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark Bridge

- (RCTBridge *)bridge
{
    static RCTBridge *bridge = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      NSURL *localServer =  kDevloperMode ? [NSURL URLWithString:kBundleURL] : [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
        bridge = [[RCTBridge alloc] initWithBundleURL:localServer moduleProvider:nil launchOptions:nil];
    });
    return bridge;
}

- (RCTRootView *)viewForModuleName:(NSString *)moduleName initialProperties:(NSDictionary *)initialProps
{
    return [[RCTRootView alloc] initWithBridge:self.bridge moduleName:moduleName initialProperties:initialProps];
}

@end

@interface HTReactNativeHostController() <MSREventBridgeEventReceiver>

@end

@implementation HTReactNativeHostController {
    NSMutableArray *_events;
    NSString *_moduleName;
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

- (id)initWithModule:(NSString *)moduleName properties:(NSDictionary *)properties {
    self = [super initWithNibName:nil bundle:nil];
    if (!self) return nil;
    _moduleName = moduleName;
    _properties = properties;
    _events = [NSMutableArray new];
    return self;
}

- (void)loadView
{
    self.view = [[MSREventBridgeBridgeManager sharedInstance] viewForModuleName:_moduleName initialProperties:_properties];
}

+ (void)applicationDidLaunch {
    // Override this function to warm up the bridge and query react native for its contents
}

- (void)addEvent:(HTReactNativeEvent *)event {
    if (!event || [self findEventFrom:event.name]) return;
    [_events addObject:event];
}

- (void)removeEvent:(HTReactNativeEvent *)event {
    if (!event) return;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:kPredicateFormat, event.name];
    _events = [[_events filteredArrayUsingPredicate:predicate] mutableCopy];
}

- (HTReactNativeEvent *)findEventFrom:(NSString *)name {
    if (!name) return nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:kPredicateFormat, name];
    return [[_events filteredArrayUsingPredicate:predicate] firstObject];
}

- (void)sendReactNativeEventWithName:(NSString *)name info:(NSDictionary *)info {
 id<MSREventBridgeEventEmitter> emitter = MSREventBridgeBridgeManager.sharedInstance.bridge.viewControllerEventEmitter;
    [emitter emitEventWithName:name info:info];
    [emitter emitEventForView:self.view name:name info:info];
}

- (void)missingEventWithName:(NSString *)name
{
    NSLog(@"missingEventWithName %@", name);
}

#pragma make - MSREventBridgeEventReceiver

// Handle events
- (void)onEventWithName:(NSString *)eventName info:(nullable NSDictionary *)info
{
    // Handle events dispatched from React Native
    NSLog(@"Received event: '%@', with info: %@", eventName, info);
    HTReactNativeEvent *event = [self findEventFrom:eventName];
    if (event) {
        event.handler(info);
    } else {
        [self missingEventWithName:eventName];
    }
}

@end
