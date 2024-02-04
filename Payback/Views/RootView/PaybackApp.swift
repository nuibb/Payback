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
        Config.shared.setupServerConfiguration()
        Logger.log(type: .info, "[Current][Environment]: \(Config.baseUrl ?? "Not Defined Yet")")
        Logger.log(type: .info, "[Current][Environment]: \(String(describing: Bundle.main.infoDictionary?["DEVELOPMENT_MODE"]))")
        
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
