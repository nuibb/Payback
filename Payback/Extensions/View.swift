//
//  View.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 1/2/24.
//

import SwiftUI

extension View {
    func toast(isShowing: Binding<Bool>, message: String, duration: TimeInterval = 3) -> some View {
        modifier(ToastModifier(isShowing: isShowing, message: message, duration: duration))
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let duration: TimeInterval
    
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

struct LoaderModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            Color.black.opacity(0.1)
            if isLoading {
                VStack {
                   
                }
            }
        }
        .padding()
    }
}
