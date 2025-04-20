//
//  Untitled.swift
//  CBExtensions
//
//  Created by Matthew Corey on 4/20/25.
//

import SwiftUI

extension EnvironmentValues {
    /**
     * A standard Environment variable to indicate whether the device is a Phone
     */
    @Entry public var isPhone = UITraitCollection.current.userInterfaceIdiom == .phone
    
    /**
     * A standard Environment variable to indicate whether the device is a Pad
     */
    @Entry public var isPad = UITraitCollection.current.userInterfaceIdiom == .pad

    /**
     * A standard Environment variable to indicate whether the device is a Mac
     */
    @Entry public var isMac = ProcessInfo.processInfo.isMacCatalystApp ? true : UITraitCollection.current.userInterfaceIdiom == .mac

    /**
     * A standard Environment variable to indicate whether the device is a Vision device
     */
    @available(iOS 17.0, *)
    @Entry public var isVision = UITraitCollection.current.userInterfaceIdiom == .vision

}
