//
//  HTReactNativeEvent.h
//  BrownFieldExample
//
//  Created by Harry Tormey on 6/23/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HTReactNativeEventHandler)(NSDictionary *info);

@interface HTReactNativeEvent : NSObject

@property (nonatomic, copy, readonly) HTReactNativeEventHandler handler;
@property (nonatomic, copy, readonly) NSString *name;

/**
 * @param    name unique name of this event NSString
 * @param    handler gets called when MSREventBridge send an event
             that corresponds to the unique name.
 * @return   HTReactNativeEvent instance.
 **/
- (id)initWithName:(NSString *)name
           handler:(HTReactNativeEventHandler)handler;

@end
