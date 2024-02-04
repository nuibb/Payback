//
//  LoaderView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 1/2/24.
//

import SwiftUI

/// NOTE: Not applicable now, maybe later will be useful for UIKit to SwiftUI conversion using UIHostingViewController
/// SwiftUI doesn't support navigation view's transparency yet but UIKit does
struct LoaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    dismiss()
                }
                .zIndex(0)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                .zIndex(1)
        }
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

extension LoaderView {
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

