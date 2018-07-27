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

        self.add(HTReactNativeEvent(name: RNEvents.PurchaseItem, handler: { [weak self] info in
            guard let sku = info?[RNProperties.sku] as? String else { return }
            /// Integrate with native purchase system in order to use SKU to make purchase with apple pay etc
            let alertMessage = "Using SKU: " + sku
            let alert = UIAlertController(title: "Purchase Item",
                                          message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }));
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) not implemented") }
}

