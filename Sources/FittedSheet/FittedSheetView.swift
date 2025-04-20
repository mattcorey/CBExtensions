//
//  FittedSheetView.swift
//  CBExtensions
//
//  Created by Matthew Corey on 4/20/25.
//

import SwiftUI
import SwiftUIExtensions

/**
 * The FittedSheet is a hybrid Popover/Sheet component that renders itself as a short
 * Sheet (fitted) on iPhones, and Popover on larger devices.
 *
 * When rendered as a Sheet, it will include a standard 'Close' button, which will take on the
 * `.tint` modifier.
 */

struct FittedSheetView<Contents: View>: View {
    @Environment(\.isPhone) var isPhone

    @Binding var presented: Bool

    @State var contentHeight: CGFloat?

    @ViewBuilder var content: Contents

    var body: some View {
        VStack {
            if isPhone {
                Button {
                    presented = false
                } label: {
                    Label("Close", systemImage: "xmark.circle.fill")
                        .labelStyle(.iconOnly)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            content
        }
        .multilineTextAlignment(.leading)
        .lineLimit(20)
        .padding()
        .sizeReader(height: $contentHeight, lock: true)
        .if(!isPhone) {
            $0
                .frame(maxWidth: 350)
        } else: {
            $0.presentationDetents([ .height((contentHeight ?? 1) ) ])
        }
    }
}

struct FittedSheetModifier<SheetContents: View>: ViewModifier {
    @Binding var isPresented: Bool

    @ViewBuilder var sheetContents: SheetContents

    func body(content: Content) -> some View {
        content.popover(isPresented: $isPresented) {
            FittedSheetView(presented: $isPresented) {
                sheetContents
            }
        }
    }
}
extension View {
    public func fittedSheet<Content>(isPresented: Binding<Bool>, @ViewBuilder contents: @escaping () -> Content) -> some View where Content: View {
        self.modifier(FittedSheetModifier(isPresented: isPresented, sheetContents: contents))
    }
}

@available(iOS 17.0, *)
#Preview("Explainer") {
    @Previewable @State var showIt = true

    Button {
        showIt.toggle()
    } label: {
        Text("Show it.")
    }
    .fittedSheet(isPresented: $showIt) {
        VStack(alignment: .leading, spacing: 16) {
            Text("Payment Defaults")
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)

            Text("When paying a bill or making a budget payment, this setting will determine whether those payments are marked as cleared or uncleared by default.")
                .fixedSize(horizontal: false, vertical: true)

            Text("This setting may be overriden by a similar Account setting.")
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
