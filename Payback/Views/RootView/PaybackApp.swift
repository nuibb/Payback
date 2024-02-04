//
//  PaybackApp.swift
//  Payback
//
//  Created by Nurul Islam on 29/1/24.
//

import SwiftUI

@main
struct PaybackApp: App {
    init() {
        /// Defining server configuration domain on the current 'Schema' by the run time
        Config.shared.setupServerConfiguration()
        Logger.log(type: .info, "[Current][Environment]: \(Config.baseUrl ?? "Not Defined Yet")")
    }
    
    var body: some Scene {
        WindowGroup {
            /// Designed a tab based application by including tabs for 'Transaction', 'Feed', 'Shopping' & 'Settings' feature.
            /// Only 'Transaction' tab is implemented now for this demo and other tabs are added for future development.
            RootView()
        }
    }
}
