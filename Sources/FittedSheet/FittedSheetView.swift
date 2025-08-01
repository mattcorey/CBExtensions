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
 * When rendered as a Sheet, it will include a standard 'Close' button by default, which will take on the
 * `.tint` modifier. The close button can be hidden by setting `showCloseButton` to false.
 */

struct FittedSheetView<Contents: View>: View {
    @Environment(\.isPhone) var isPhone

    @Binding var presented: Bool
    
    var showCloseButton: Bool = true

    @State var contentHeight: CGFloat?

    @ViewBuilder var content: Contents

    var body: some View {
        VStack {
            if isPhone && showCloseButton {
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
    
    var showCloseButton: Bool = true

    @ViewBuilder var sheetContents: SheetContents

    func body(content: Content) -> some View {
        content.popover(isPresented: $isPresented) {
            FittedSheetView(presented: $isPresented, showCloseButton: showCloseButton) {
                sheetContents
            }
        }
    }
}
extension View {
    public func fittedSheet<Content>(isPresented: Binding<Bool>, showCloseButton: Bool = true, @ViewBuilder contents: @escaping () -> Content) -> some View where Content: View {
        self.modifier(FittedSheetModifier(isPresented: isPresented, showCloseButton: showCloseButton, sheetContents: contents))
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

@available(iOS 17.0, *)
#Preview("No Close Button") {
    @Previewable @State var showIt = true

    Button {
        showIt.toggle()
    } label: {
        Text("Show without close button")
    }
    .fittedSheet(isPresented: $showIt, showCloseButton: false) {
        VStack(alignment: .leading, spacing: 16) {
            Text("Custom Dismissal")
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)

            Text("This sheet doesn't show a close button. Users must dismiss it using the provided action or by tapping outside on iPad.")
                .fixedSize(horizontal: false, vertical: true)
            
            Button {
                showIt = false
            } label: {
                Text("Dismiss")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

@available(iOS 26.0, *)
#Preview("Memory Style") {
    @Previewable @State var showIt = true

    Button {
        showIt.toggle()
    } label: {
        Text("Show without close button")
    }
    .fittedSheet(isPresented: $showIt, showCloseButton: false) {
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .leading) {
                Button {
                    showIt = false
                } label: {
                    Label("Close", systemImage: "xmark")
                        .labelStyle(.iconOnly)
                }
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)
                .glassEffect(in: .circle)
                
                Label("New Memories", systemImage: "brain")
                    .font(.headline.bold())
                    .foregroundStyle(.purple)
                    .frame(maxWidth: .infinity)
            }
            
            Text("This sheet doesn't show a close button. Users must dismiss it using the provided action or by tapping outside on iPad.")

            Text("This sheet doesn't show a close button. Users must dismiss it using the provided action or by tapping outside on iPad.")

            Text("This sheet doesn't show a close button. Users must dismiss it using the provided action or by tapping outside on iPad.")

        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.top)
    }
}
