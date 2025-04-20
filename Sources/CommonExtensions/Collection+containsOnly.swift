//
//  File.swift
//  CBExtensions
//
//  Created by Matthew Corey on 4/20/25.
//

import Foundation

extension Collection where Element: Equatable {
    public func containsOnly(_ element: Element) -> Bool {
        return self.contains(element) && self.count == 1
    }
}
