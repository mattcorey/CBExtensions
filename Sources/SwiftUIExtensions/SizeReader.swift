//
//  WidthReader.swift
//  CBExtensions
//
//  Created by Matthew Corey on 4/20/25.
//

import SwiftUI

struct Sizerer: Equatable {
    var width: CGFloat?
    var height: CGFloat?
}

public struct SizeReader: ViewModifier {
    var width: Binding<CGFloat?>?
    var height: Binding<CGFloat?>?
    
    var lock = false

    public func body(content: Content) -> some View {
        if width == nil || height == nil {
            content
                .frame(width: lock ? width?.wrappedValue : nil, height: lock ? height?.wrappedValue : nil)
                .onGeometryChange(for: CGFloat.self) { proxy in
                    if width != nil && height == nil {
                        proxy.size.width
                    } else {
                        proxy.size.height
                    }
                } action: { newValue in
                    width?.wrappedValue = newValue
                    height?.wrappedValue = newValue
                }
        } else {
            content
                .frame(width: lock ? width?.wrappedValue : nil, height: lock ? height?.wrappedValue : nil)
                .onGeometryChange(for: Sizerer.self) { proxy in
                    Sizerer(width: proxy.size.width, height: proxy.size.height)
                } action: { newValue in
                    width?.wrappedValue = newValue.width
                    height?.wrappedValue = newValue.height
                }
        }
    }
}

extension View {
    /**
     * Sets bindings that will track the dimensions of the view that it is attached to.
     */
    public func sizeReader(width: Binding<CGFloat?>? = nil, height: Binding<CGFloat?>? = nil, lock: Bool = false) -> some View {
        self.modifier(SizeReader(width: width, height: height, lock: lock))
    }
}
