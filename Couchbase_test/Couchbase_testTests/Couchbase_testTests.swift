//
//  Couchbase_testTests.swift
//  Couchbase_testTests
//
//  Created by Ajith Anthony on 5/2/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import XCTest
@testable import Couchbase

class Couchbase_testTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetDocument() {
        guard let document = CouchbaseStack.shared.openDocument(with: "test_id_7218") else { return }
        let actual = document.toDictionary()
        print(actual)
        XCTAssertNotNil(actual)
    }
    
}
