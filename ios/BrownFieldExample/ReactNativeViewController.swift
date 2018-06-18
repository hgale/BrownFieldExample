//
//  ViewController.swift
//  BrownFieldExample
//
//  Created by Harry Tormey on 6/17/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import React
import UIKit

class ReactNativeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")
        let mockData:NSDictionary = ["scores":
            [
                ["name":"Alex", "value":"42"],
                ["name":"Joel", "value":"10"]
            ]
        ]
        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "BrownFieldExample",
            initialProperties: mockData as [NSObject : AnyObject],
            launchOptions: nil
        )
        self.view = rootView
//        self.view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

