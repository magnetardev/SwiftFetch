import XCTest
@testable import SwiftFetch

struct Project: Decodable {
    let id: String
    let name: String
    let desc: String
    let version: String
    let icon: String
    let link: String
    let banner: String
}

final class SwiftFetchTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        fetch(url: URL(string: "Hello")!).then { res in
            let projectList = res.json(handler: [Project].self) as! [Project];
            print(projectList);
        }.catch { err in
            print(err);
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
