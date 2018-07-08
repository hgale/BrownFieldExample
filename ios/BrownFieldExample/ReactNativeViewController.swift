//
//  ReactNativeViewController.swift
//  BrownFieldExample
//
//  Created by Harry Tormey on 6/17/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import React
import UIKit

class ReactNativeViewController: HTReactNativeHostController {

    public static var queryController: HTReactNativeHostController?
    
    override init!(module: String!, properties: [AnyHashable : Any]!) {
        super.init(module: module, properties: properties)
        self.setupEvents()
    }

    func setupEvents() {

        self.add(HTReactNativeEvent(name: RNEvents.DismissScreen, handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))

        self.add(HTReactNativeEvent(name: RNEvents.EmitEvent, handler: { info in
            guard let foo = info?["Foo"] as? String else { return }
            print("Value passed back from ReactNative is ", foo)
        }));

        self.add(HTReactNativeEvent(name: RNEvents.ListScreens, handler: { info in
            guard let screens = info?[RNProperties.screens] as? [[String: Any]] else { return }
            ReactNativeScreenManager.sharedInstance.reset()
            for screen in screens {
                guard let name = screen["name"] as? String,
                    let properties = screen["properties"] as? Dictionary<AnyHashable,Any> else {
                    continue
                }
                print("Screen name is ", name)
                print("Screen properties is ", properties)
                ReactNativeScreenManager.sharedInstance.addScreen(screen: name, properties:properties)
            }
            //ReactNativeScreenManager
            // TODO: build arrray of screens and configs, then pick one randomly.
        }));
    }
    
    override class func applicationDidLaunch() {
        super.applicationDidLaunch()
        var properties : Dictionary = Dictionary<AnyHashable,Any>()
        properties[RNProperties.screen] = RNScreens.Query
        properties[RNProperties.getScreens] = true
        ReactNativeViewController.queryController = ReactNativeViewController(module: RNProperties.moduleName, properties: properties)
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) not implemented") }
}

