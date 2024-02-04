//
//  Utils.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 31/1/24.
//

import Foundation

struct Utils {
    static func after(seconds: Double, callback:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            callback()
        }
    }
}
