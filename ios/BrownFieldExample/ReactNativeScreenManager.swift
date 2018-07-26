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

    init() {
        /// screens.json is generated from the contents of the src/screens directory via a script that run as a post compile script
        /// This script iterates through all of the screens in the screens directory.
        if let path = Bundle.main.path(forResource: RNProperties.screens, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)

                if let jsonResult = json as? Dictionary<String, AnyObject>, let screens = jsonResult[RNProperties.screens] as? [[String: Any]] {
                    for screen in screens {
                        guard let name = screen[RNProperties.name] as? String,
                            let properties = screen[RNProperties.properties] as? Dictionary<String, AnyObject> else {
                                continue
                        }
                        self.addScreen(screen: name, properties:properties)
                    }
                }
            } catch {
                print("Error occurred reading screens.json")
            }
        }
    }
    
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
