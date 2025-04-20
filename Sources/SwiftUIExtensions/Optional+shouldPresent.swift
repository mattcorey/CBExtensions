//
//  OptionalProtocol.swift
//  CBExtensions
//
//  Created by Matthew Corey on 4/20/25.
//

import SwiftUI

public protocol OptionalProtocol {
    associatedtype Wrapped

    var wrapped: Wrapped? { get }
    static var none: Self { get }
}

extension Optional: OptionalProtocol {
    public var wrapped: Wrapped? { self }
}

extension Binding where Value: OptionalProtocol {
    /**
     * A convenience wrapper that allows the use of any Optional variable to be translated to a Binding<Bool>.  This is most commonly used in SwiftUI to display views, such as:
     *
     * ```
     *      view.sheet(isPresented: myOptional.shouldPresent)
     * ```
     */
    @MainActor
    public var shouldPresent: Binding<Bool> {
        Binding<Bool>(
            get: {
                self.wrappedValue.wrapped != nil
            },
            set: { newValue in
                if !newValue {
                    self.wrappedValue = .none
                }
            }
        )
    }
}
