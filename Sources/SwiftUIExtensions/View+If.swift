//
//  View+If.swift
//  CBExtensions
//
//  Created by Matthew Corey on 4/20/25.
//

import SwiftUI

extension View {
    /**
     * Allows for a conditionally applying SwiftUI modifiers if the given conditions are met
     *
     * *WARNING:*  The use of these modifiers can cause your animations to break, because they circumvent the SwiftUI type system - be aware of what you're doing!  May only be advisable for
     * conditions that are platform dependent, and will not change while using the app.  More information:  https://www.objc.io/blog/2021/08/24/conditional-view-modifiers/
     */
    public func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> TupleView<(Self?, Content?)> {
        if conditional {
            return TupleView((nil, content(self)))
        } else {
            return TupleView((self, nil))
        }
    }

    /**
     * Allows for a conditionally applying SwiftUI modifiers if the given Optional is not nil, and provides the unwrapped value of the Optional as a parameter to the resulting closure
     *
     * *WARNING:*  The use of these modifiers can cause your animations to break, because they circumvent the SwiftUI type system - be aware of what you're doing!  May only be advisable for
     * conditions that are platform dependent, and will not change while using the app.  More information:  https://www.objc.io/blog/2021/08/24/conditional-view-modifiers/
     */
    public func ifLet<Content: View, IsOptional: OptionalProtocol>(_ optional: IsOptional, content: (Self, IsOptional.Wrapped) -> Content) -> TupleView<(Self?, Content?)> {
        if let unwrapped = optional.wrapped {
            return TupleView((nil, content(self, unwrapped)))
        } else {
            return TupleView((self, nil))
        }
    }

    /**
     * Allows for a conditionally applying SwiftUI modifiers if the given conditions are met, or applying separate modifiers if the conditions are not met.
     *
     * *WARNING:*  The use of these modifiers can cause your animations to break, because they circumvent the SwiftUI type system - be aware of what you're doing!  May only be advisable for
     * conditions that are platform dependent, and will not change while using the app.  More information:  https://www.objc.io/blog/2021/08/24/conditional-view-modifiers/
     */
    public func `if`<IfContent: View, ElseContent: View>(_ conditional: Bool, if ifContent: (Self) -> IfContent, else elseContent: (Self) -> ElseContent) -> TupleView<(IfContent?, ElseContent?)> {
        if conditional {
            return TupleView((ifContent(self), nil))
        } else {
            return TupleView((nil, elseContent(self)))
        }
    }

    public func apply<V: View>(@ViewBuilder _ block: (Self) -> V) -> V { block(self) }
}

@available(iOS 18.0, *)
#Preview("Broken Animation Example - don't do this") {
    @Previewable @State var toggled = false

    VStack {
        Toggle("Toggle", isOn: $toggled.animation())
        Rectangle()
            .if(toggled) {
                $0.frame(width: 100)
            }
    }
}

@available(iOS 18.0, *)
#Preview("Good Animation Example") {
    @Previewable @State var toggled = false

    VStack {
        Toggle("Toggle", isOn: $toggled.animation())
        Rectangle()
            .frame(width: toggled ? 100 : nil)
    }
}
