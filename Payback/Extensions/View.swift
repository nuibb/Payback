//
//  View.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 1/2/24.
//

import SwiftUI

extension View {
    func showToast(isShowing: Binding<Bool>, message: String, duration: TimeInterval = 3) -> some View {
        modifier(ToastModifier(isShowing: isShowing, message: message, duration: duration))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
