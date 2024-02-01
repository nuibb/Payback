//
//  ToastView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 1/2/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let duration: TimeInterval
    
    @ViewBuilder
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    HStack() {
                        Spacer()
                        Image(systemName: "exclamationmark.circle")
                            .padding(.trailing, 10)
                        Text(message)
                        Spacer()
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(.red)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .onAppear {
                        setDuration()
                    }
                    
                    Spacer()
                }
            }
        }
        .padding()
    }
    
    private func setDuration() {
        Utils.after(seconds: duration) {
            withAnimation {
                isShowing = false
            }
        }
    }
}
