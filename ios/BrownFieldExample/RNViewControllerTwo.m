//
//  RNViewControllerTwo.m
//  BrownFieldExample
//
//  Created by Harry Tormey on 7/1/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

#import <React/RCTRootView.h>
#import <React/RCTLog.h>
#import <React/RCTUIManager.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTBridge.h>
#import <React/RCTRootView.h>

#import "MSREventBridge.h"


#import <Foundation/Foundation.h>

#import "RNViewControllerTwo.h"

/**
 * RCTBridge to be used across the component to not have a hit if multiple RTCViews are there
 */
@interface MSREventBridgeBridgeManager : NSObject<RCTBridgeDelegate>

/**
 * Returns the shared instance of the bridge manager for react native navigation
 */
+ (instancetype)sharedInstance;

/**
 * Shared bridge used in the bridge manager
 */
@property (readonly) RCTBridge *bridge;

/**
 * Create a new view for a given module name and pass in initial properties
 */
- (RCTRootView *)viewForModuleName:(NSString *)moduleName initialProperties:(NSDictionary *)initialProps;

/**
 * Returns the root view for a given react tag. The react tag can be from a view that is within the view hierarchy
 */
- (void)rootViewForReactTag:(NSNumber *)reactTag withCompletion:(void (^)(UIView *view))completion;

@end


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
        NSURL *localServer =  [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
        bridge = [[RCTBridge alloc] initWithBundleURL:localServer moduleProvider:nil launchOptions:nil];
        bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
    });
    return bridge;
}

- (void)rootViewForReactTag:(NSNumber *)reactTag withCompletion:(void (^)(UIView *view))completion
{
    [self.bridge.uiManager rootViewForReactTag:reactTag withCompletion:completion];
}

- (RCTRootView *)viewForModuleName:(NSString *)moduleName initialProperties:(NSDictionary *)initialProps
{
    return [[RCTRootView alloc] initWithBridge:self.bridge moduleName:moduleName initialProperties:initialProps];
}

#pragma mark RCTBridgeDelegate

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
    return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
}

@end

@implementation UIViewController (MSREventBridgeModule)

- (id<MSREventBridgeEventEmitter>)viewControllerEventEmitter
{
    return MSREventBridgeBridgeManager.sharedInstance.bridge.viewControllerEventEmitter;
}

@end

static NSString * const PresentScreenEvent = @"PresentScreen";
static NSString * const DismissScreenEvent = @"DismissScreen";
static NSString * const LoadDataEvent = @"LoadData";
static NSString * const LoadDataEventCountParameterKey = @"count";
static NSString * const DidSelectRowEvent = @"DidSelectRow";

@interface RNViewControllerTwo () <MSREventBridgeEventReceiver>

// Some UUID to test out the event dispatching and receiving is working per view controller
@property (nonatomic) NSUUID *UUID;


@end

@implementation RNViewControllerTwo

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _UUID = [NSUUID UUID];
    
    return self;
}

- (void)loadView
{
    self.view = [[MSREventBridgeBridgeManager sharedInstance] viewForModuleName:@"BrownFieldExample" initialProperties:nil];
}

#pragma mark - <MSREventBridgeEventReceiver>

// Callback from the JS side. One subview from the root node did send an event
- (void)onEventWithName:(NSString *)eventName info:(NSDictionary *)info
{
    RCTLog(@"%@ - Received event: '%@', with info: %@", self.UUID.UUIDString, eventName, info);
    
    // Handle events dispatched from React Native
    
    // Example for PresentScreen event
    if ([eventName isEqualToString:PresentScreenEvent] ) {
//        ViewController *newViewController = [ViewController new];
//        [self presentViewController:newViewController animated:YES completion:nil];
        return;
    }
    
    // Example for DismissScreen event
    if ([eventName isEqualToString:DismissScreenEvent]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    // Example for DidSelectRow event
    if ([eventName isEqualToString:DidSelectRowEvent]) {
        RCTLog(@"Did Select Row With info: %@", info);
        
        // Send an event with name 'eventName' to listeners for this event within the React Native component hierarchy
        // of that is managed by this view controller
        [self.viewControllerEventEmitter emitEventForView:self.view name:@"eventName" info:@{
                                                                                             @"rowSelected" : info[@"rowID"]
                                                                                             }];
        return;
    }
    
    // After receiving an event send some event back with name `eventName`.
    [self.viewControllerEventEmitter emitEventForView:self.view name:@"eventName" info:@{
                                                                                         @"UUID" : _UUID.UUIDString,
                                                                                         @"data" : @"data"
                                                                                         }];
}

@end
