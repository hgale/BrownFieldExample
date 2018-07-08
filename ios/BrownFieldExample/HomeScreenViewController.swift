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
        
        let buttonTwo = UIButton(frame: CGRect(x: 100, y: 180, width: 150, height: 50))
        buttonTwo.backgroundColor = .red
        buttonTwo.setTitle("Pull screens", for: .normal)
        buttonTwo.addTarget(self, action: #selector(buttonActionTwo), for: .touchUpInside)
        self.view.addSubview(buttonTwo)
    }

    @objc func buttonActionTwo(sender: UIButton!) {
        // maintain a static array of screens, then toggle between screens to pick.
        ReactNativeViewController.applicationDidLaunch();
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        var properties : Dictionary = Dictionary<AnyHashable,Any>()
        properties["screen"] = "UpsellScreenOne"
        let viewController =
            ReactNativeViewController(module: "BrownFieldExample", properties: properties)
        self.present(viewController!, animated: false, completion: nil)
    }
    
}

