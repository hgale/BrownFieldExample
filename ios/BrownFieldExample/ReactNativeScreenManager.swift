//
//  ReactNativeScreenManager.swift
//  BrownFieldExample
//
//  Created by Harry Tormey on 7/8/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation

class ReactNativeScreenManager {
    static let sharedInstance: ReactNativeScreenManager = { ReactNativeScreenManager() } ()

    fileprivate var screenProperties = Dictionary<String,Any>()
    fileprivate var screens = [String]()
    
    open func addScreen(screen: String, properties: Dictionary<AnyHashable,Any>) {
        self.screenProperties[screen] = properties
        self.screens.append(screen)
    }

    open func reset() {
        self.screenProperties =  Dictionary<String,Any>()
        self.screens = [String]()
    }
    
    /// This function is meant to simulate an A/B test by picking a random screen
    open func getRandomScreen() -> Dictionary<String,Any> {
        var screen = Dictionary<String,Any>()
        if (!self.screens.isEmpty) {
            let randomIndex = Int(arc4random_uniform(UInt32(self.screens.count)))
            let screenName = self.screens[randomIndex]
            var properties = self.screenProperties[screenName] as! [String : Any]
            properties[RNProperties.screen] = screenName
            screen[RNProperties.name] = screenName
            screen[RNProperties.properties] = properties
        }
        return screen
    }
}
