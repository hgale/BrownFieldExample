//
//  ReactNativeConstants.swift
//  BrownFieldExample
//
//  Created by Harry Tormey on 7/8/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation

/// Events sent back and forth over the React Native bridge.
/// They must corrsepond to equivalent events in JavaScript.
public struct RNEvents {
    public static let DismissScreen = "DismissScreen"
    public static let PurchaseItem = "PurchaseItem"
    // Test event which causes react native
    public static let EmitEvent = "EmitEvent"
        
    /// Get list of all screens contained in React Native bundle
    /// along with the default properties to use with them
    public static let ListScreens = "ListScreens"
}

/// Property Keys that are shared between native and JavaScript
public struct RNProperties {
    /// Name of the react native bundle.
    public static let moduleName = "BrownFieldExample"
    public static let getScreens = "getScreens"
    public static let screens = "screens"
    public static let screen = "screen"
    public static let name = "name"
    public static let sku = "sku"
    public static let properties = "properties"
    public static let screenName = "screenName"
}

public struct RNScreens {
    public static let Query = "Query"
    public static let UpsellScreenOne = "UpsellScreenOne"
}
