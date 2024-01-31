//
//  EndPoint.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String:String] { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api-test.payback.com"
    }
    
    var header: [String: String] {
        return [
            //"Authorization": "Bearer \(accessToken)"
            "Content-Type": "application/json"
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}

