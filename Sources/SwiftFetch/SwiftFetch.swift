import Foundation
import Bluebird

public class FetchResponse {
    
    // Init Variables
    public let data: Data;
    public let response: URLResponse;
    
    // Init
    init(data: Data, response: URLResponse) {
        self.response = response;
        self.data = data;
    }
    
    // Parse as text
    public func text() -> String {
        return String(data: self.data, encoding: String.Encoding.utf8)!
    }
    
    // Parse as JSON
    public func json<T: Decodable>(handler: T.Type) -> Any {
        let decoder = JSONDecoder();
        do {
            let data = try decoder.decode(handler, from: self.data)
            return data;
        } catch let err {
            return err
        }
    }
}


// Main Fetch Function
public func fetch(url: URL) -> Promise<FetchResponse> {
    return Promise<FetchResponse> { resolve, reject in
        DispatchQueue(label: "fetch.operation").async {
            
            // New Request
            let request = NSMutableURLRequest(url: url);
            
            // New Session
            let session = URLSession.shared;
            
            // HTTP Method
            request.httpMethod = "GET";
            
            // Run Task
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if (error != nil) {
                    // Reject if error.
                    reject(error!);
                } else {
                    // Resolve if ok.
                    let responseData = FetchResponse(data: data!, response: response!)
                    resolve(responseData);
                }
            });
            task.resume();
        }
    }
}
