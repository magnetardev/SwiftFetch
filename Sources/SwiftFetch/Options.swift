//
//  Options.swift
//  
//
//  Created by Tucker Morley on 7/18/19.
//

import Foundation

public struct FetchOptions {
    
    public init(headers: [String:String]? = nil, body: Data? = nil, method: FetchMethod? = .GET) {
        self.headers = headers
        self.body = body
        self.method = method
    }
    
    public var headers: [String:String]? = nil
    public var body: Data? = nil
    public var method: FetchMethod? = .GET
}
