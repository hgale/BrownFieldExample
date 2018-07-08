//
//  HTReactNativeHostController.h
//  BrownFieldExample
//
//  Created by Harry Tormey on 6/17/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTReactNativeEvent;
@class HTReactNativeHostController;
@class RCTBridge;

@interface HTReactNativeHostController : UIViewController

+ (void)applicationDidLaunch;

- (id)initWithModule:(NSString *)moduleName properties:(NSDictionary *)properties;

- (void)addEvent:(HTReactNativeEvent *)event;
- (void)removeEvent:(HTReactNativeEvent *)event;

- (void)sendReactNativeEventWithName:(NSString *)name info:(NSDictionary *)info;

- (void)missingEventWithName:(NSString *)name;

@end
