//
//  Response.swift
//  
//
//  Created by Tucker Morley on 7/18/19.
//

import Foundation

public class FetchResponse {
    
    // Init Variables
    public let data: Data;
    public let response: URLResponse;
    
    // Init
    init(data: Data, response: URLResponse) {
        self.response = response
        self.data = data
    }
    
    // Parse as text
    public func text() -> String {
        return String(data: self.data, encoding: String.Encoding.utf8)!
    }
    
    // Parse as JSON
    public func json<T: Decodable>(handler: T.Type) -> Any {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(handler, from: self.data)
            return data
        } catch let err {
            return err
        }
    }
}
