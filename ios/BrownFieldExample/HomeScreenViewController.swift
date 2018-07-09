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

        let title = UILabel()
        title.text = "Native Screen"
        title.font = title.font.withSize(25)
        title.center.x = self.view.center.x - 75
        title.center.y = self.view.center.y
        title.textAlignment = .center
        title.sizeToFit()
        self.view.addSubview(title)

        /// Button shows VC that displays an example promotion screen powered by React Native
        let reactNativeVCButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        reactNativeVCButton.center.x = self.view.center.x
        reactNativeVCButton.center.y = self.view.center.y + title.frame.height + 100
        reactNativeVCButton.layer.borderWidth = 2.0
        reactNativeVCButton.layer.borderColor = UIColor.black.cgColor
        reactNativeVCButton.setTitleColor(.black, for: .normal)
        reactNativeVCButton.setTitle("Show Promotion", for: .normal)
        reactNativeVCButton.addTarget(self, action: #selector(showReactNativeVC), for: .touchUpInside)
        self.view.addSubview(reactNativeVCButton)
    }
    
    @objc func showReactNativeVC(sender: UIButton!) {
        // TODO: Add some guard statements in here
        let screen = ReactNativeScreenManager.sharedInstance.getRandomScreen()
        let properties = screen[RNProperties.properties]
        let viewController =
            ReactNativeViewController(module: RNProperties.moduleName, properties: properties as! [AnyHashable : Any])
        self.present(viewController!, animated: false, completion: nil)
    }
    
}

