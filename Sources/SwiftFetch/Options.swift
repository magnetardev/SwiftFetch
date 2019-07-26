//
//  Options.swift
//  
//
//  Created by Tucker Morley on 7/18/19.
//

import Foundation

public struct FetchOptions {
    public var headers: [String:String]? = nil
    public var body: Data? = nil
    public var method: FetchMethod? = .GET
}
