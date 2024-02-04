//
//  Config.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 31/1/24.
//

import Foundation

/*
var isOnProd: Bool = {
    guard let mode: String = Bundle.main.infoDictionary?["DEVELOPMENT_MODE"] as? String else { return true }
    return mode == "production"
}()
 */

struct Config {
    static let shared = Config()
    private init() {}
    
    struct log {
        static let enabled = true
    }
    
    struct constant {
        static var applicationGroupIdentifier: String {
            guard let applicationGroupIdentifier = Bundle.main.object(forInfoDictionaryKey: "applicationGroupIdentifier") as? String else {
                fatalError("applicationGroupIdentifier should be defined")
            }
            return applicationGroupIdentifier
        }
    }
    
    static var baseUrl: String?
    private enum BaseUrl: String {
        case LOCAL = "localhost.com"//assuming
        case DEV = "api-test.payback.com"
        case QA = "api-qa.payback.com"//assuming
        case DEMO = "api-demo.payback.com"//assuming
        case PROD = "api.payback.com"
    }
    
    struct url {
        static var scheme: String { "https" }
        static var host: String {
            baseUrl ?? BaseUrl.LOCAL.rawValue
        }
        static var applicationType: String {
            return "application/json"
        }
    }
    
    // To See in which environment this version of app is building on
    func setupServerConfiguration() {
        #if LOCAL
        Config.baseUrl = BaseUrl.LOCAL.rawValue
        #elseif DEV
        Config.baseUrl = BaseUrl.DEV.rawValue
        #elseif QA
        Config.baseUrl = BaseUrl.QA.rawValue
        #elseif DEMO
        Config.baseUrl = BaseUrl.DEMO.rawValue
        #elseif PROD
        Config.baseUrl = BaseUrl.PROD.rawValue
        #endif
    }
    
    func getDataProvider() -> TransactionDataProvider {
        #if LOCAL
        return MockDataProvider()
        #else
        return ApiDataProvider()
        #endif
    }
}

extension Config.url {
    
}
