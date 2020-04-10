//
//  ObjectCreationTests.swift
//  
//
//  Created by Vladislav Fitc on 06/04/2020.
//

import Foundation
import XCTest
@testable import AlgoliaSearchClientSwift

class ObjectCreationTests: XCTestCase {
  
  func testCoding() throws {
    let date = Date()
    try AssertEncodeDecode(ObjectCreation(createdAt: date, taskID: "16657823001", objectID: "5117231"), [
      "createdAt" : .init(date),
      "objectID" : "5117231",
      "taskID" : "16657823001"
    ])
  }
  
}
