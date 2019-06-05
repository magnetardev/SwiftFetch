import Foundation
import Bluebird

public class FetchResponse {
    // Init Variables
    let data: Data;
    let response: URLResponse;
    
    init(data: Data, response: URLResponse) {
        self.response = response;
        self.data = data;
    }
    
    func text() -> String {
        return String(data: self.data, encoding: String.Encoding.utf8)!
    }
    
    func json<T: Decodable>(handler: T.Type) -> Any {
        let decoder = JSONDecoder();
        do {
            let data = try decoder.decode(handler, from: self.data)
            return data;
        } catch let err {
            return err
        }
    }
}

public func fetch(url: URL) -> Promise<FetchResponse> {
    return Promise<FetchResponse> { resolve, reject in
        DispatchQueue(label: "fetch.operation").async {
            let request = NSMutableURLRequest(url: url);
            let session = URLSession.shared;
            request.httpMethod = "GET";
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if (error != nil) {
                    reject(error!);
                } else {
                    let responseData = FetchResponse(data: data!, response: response!)
                    resolve(responseData);
                }
            });
            task.resume();
        }
    }
}
