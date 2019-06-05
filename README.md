# SwiftFetch

Similar to the JavaScript fetch() Promise, SwiftFetch is a simple and easy to use way to fetch web content in Swift. Since SwiftFetch expands off of Bluebird, it is recommended that you understand how to use that.

**Dependencies**
- [Bluebird](https://github.com/AndrewBarba/Bluebird.swift)

### Documentation

**Import**

```swift
import SwiftFetch
```

**Fetch**

Fetch returns a promise, similar to JavaScript. The resolved value from the fetch is a `FetchResponse` item. This will let you run things like .text() and .json() easily, more info on this class can be found below. Below is an example of a fetch call.

```swift
fetch(url: URL(string: "https://google.com")!).then { res in
    let textResponse = res.text();
    print(textResponse);
}.catch { err in
    print(err);
}
```

**FetchResponse**
If successful, a fetch will return a `FetchResponse` in it's Promise. This helps streamline the process, and make it more similar to the JavaScript version.

```swift
public class FetchResponse {
    public let data: Data;
    public let response: URLResponse;
    public func text() -> String;
    public func json<T: Decodable>(handler: T.Type) -> Any;
}
```
- `data` is the returned Data from the fetch call.
- `response` is the returned Response from the fetch call.
- `text()` is a simple function that converts the data into text.
- `json()` simplifies the json parsing process. It takes in a Decodable struct.




### Examples
**Text**
```swift
fetch(url: URL(string: "https://google.com")!).then { res in
    let textResponse = res.text();
    print(textResponse);
}.catch { err in
    print(err);
}
```

**JSON**
```swift
struct Project: Decodable {
    let id: String
    let name: String
    let desc: String
    let version: String
    let icon: String
    let link: String
    let banner: String
}
fetch(url: URL(string: "https://api.magnetardev.pro/magnetar/get/projects")!).then { res in
    let projectsList = res.json(handler: [Project].self) as! [Project];
    print(projectsList);
}.catch { error in
    print(error);
};
```
