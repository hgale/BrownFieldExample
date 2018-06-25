//
//  HTReactNativeEvent.m
//  BrownFieldExample
//
//  Created by Harry Tormey on 6/23/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

#import "HTReactNativeEvent.h"

@implementation HTReactNativeEvent

- (id)init {
    NSAssert(![self isMemberOfClass:[HTReactNativeEvent class]], @"Do not call init directly!");
    return [super init];
}

- (id)initWithName:(NSString *)name
           handler:(HTReactNativeEventHandler)handler
{
    
    NSAssert(!(!name || !handler), @"Name or handler missing");
    if (self = [super init])
    {
        _handler = [handler copy];
        _name = name;
    }
    
    return self;
}

@end
