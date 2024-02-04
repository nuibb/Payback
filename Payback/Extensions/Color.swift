//
//  Color.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import SwiftUI

extension Color {
    /// Assuming to generate random color for categories. In real project, maybe there will be enum type with defined category & color.
    static var random: Color {
        let red = Double.random(in: 0.0...1.0)
        let green = Double.random(in: 0.0...1.0)
        let blue = Double.random(in: 0.0...1.0)
        return Color(red: red, green: green, blue: blue)
    }
    
    /// For later use, to create color from hex value
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}

extension Color {
    static let primaryColor = Color(hex: "C6426E")
    static let textBlack = Color(hex: "313131")
}
