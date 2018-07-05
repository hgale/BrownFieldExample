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
    
    override init!(screen: String!, properties: [AnyHashable : Any]!) {
        super.init(screen: screen, properties: properties);
        self.setupEvents()
    }

    func setupEvents() {
        self.add(HTReactNativeEvent(name: "DismissScreen", handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        self.add(HTReactNativeEvent(name: "EmitEvent", handler: { info in
            guard let foo = info?["Foo"] as? String else { return }
            print("Value passed back from ReactNative is ", foo)
        }));
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) not implemented") }
}

