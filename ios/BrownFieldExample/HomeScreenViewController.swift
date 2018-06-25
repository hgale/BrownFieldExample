//
//  HomeScreenViewController.swift
//  BrownFieldExample
//
//  Created by Harry Tormey on 6/17/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 150, height: 50))
        button.backgroundColor = .green
        button.setTitle("React Native VC", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        let properties : Dictionary = Dictionary<AnyHashable,Any>()
        let reactNativeViewController =
            HTReactNativeHostController(screen: "ScreenOne", properties: properties)
        self.present(reactNativeViewController!, animated: false, completion: nil)
    }
}

