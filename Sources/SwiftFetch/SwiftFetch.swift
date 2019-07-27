import Foundation
import Bluebird


// Main Fetch Function
public func fetch(url: URL, options: FetchOptions? = nil) -> Promise<FetchResponse> {
    return Promise<FetchResponse> { resolve, reject in
        DispatchQueue(label: "fetch.operation").async {
            
            // New Request
            let request = NSMutableURLRequest(url: url);
            
            // New Session
            let session = URLSession.shared;
            
            // HTTP Method
            request.httpMethod = "GET";
            
            if (options != nil) {                
                if (options?.headers != nil) {
                    for (key, value) in options?.headers ?? [:] {
                        request.setValue(key, forHTTPHeaderField: value)
                    }
                }
                
                if (options?.body != nil) {
                    request.httpBody = options?.body
                }
            
                if (options?.method != nil) {
                    request.httpMethod = (options?.method)!.rawValue;
                }
            }
            
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
