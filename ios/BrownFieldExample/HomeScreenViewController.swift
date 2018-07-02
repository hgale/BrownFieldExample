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
        
        let buttonOne = UIButton(frame: CGRect(x: 100, y: 100, width: 150, height: 50))
        buttonOne.backgroundColor = .green
        buttonOne.setTitle("React Native VC", for: .normal)
        buttonOne.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(buttonOne)
        
        
        let buttonTwo = UIButton(frame: CGRect(x: 100, y: 200, width: 150, height: 50))
        buttonTwo.backgroundColor = .red
        buttonTwo.setTitle("React Native VC2", for: .normal)
        buttonTwo.addTarget(self, action: #selector(buttonActionTwo), for: .touchUpInside)
        self.view.addSubview(buttonTwo)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        let properties : Dictionary = Dictionary<AnyHashable,Any>()
        let reactNativeViewController =
            HTReactNativeHostController(screen: "ScreenOne", properties: properties)
        self.present(reactNativeViewController!, animated: false, completion: nil)
    }
    
    @objc func buttonActionTwo(sender: UIButton!) {
        print("Button2  tapped")
        let reactNativeViewController = RNViewControllerTwo()
        self.present(reactNativeViewController, animated: false, completion: nil)
    }
}

