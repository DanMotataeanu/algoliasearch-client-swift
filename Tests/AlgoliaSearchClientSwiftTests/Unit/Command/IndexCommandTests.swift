//
//  IndexCommandTests.swift
//  
//
//  Created by Vladislav Fitc on 26/03/2020.
//

import Foundation
import XCTest
@testable import AlgoliaSearchClientSwift

class IndexCommandTests: XCTestCase, AlgoliaCommandTest {
  
  func testCheckName() {
    XCTAssertEqual(IndexName.PathCompletion.batch.rawValue, "batch")
  }
  
  func testDeleteIndex() {
    let command = Command.Index.DeleteIndex(indexName: test.indexName, requestOptions: test.requestOptions)
    check(command: command,
          callType: .write,
          method: .delete,
          urlPath: "/1/indexes/testIndex",
          queryItems: [.init(name: "testParameter", value: "testParameterValue")],
          body: nil,
          requestOptions: test.requestOptions)
  }
  
  func testBatchOperation() {
    let command = Command.Index.Batch(indexName: test.indexName, batchOperations: test.batchOperations, requestOptions: test.requestOptions)
    check(command: command,
          callType: .write,
          method: .post,
          urlPath: "/1/indexes/testIndex/batch",
          queryItems: [.init(name: "testParameter", value: "testParameterValue")],
          body: FieldWrapper(requests: test.batchOperations).httpBody,
          requestOptions: test.requestOptions)
  }
  
  func testOperationMove() {
    let operation: IndexOperation = .init(action: .move, destination: test.anotherIndexName, scopes: nil)
    let command = Command.Index.Operation(indexName: test.indexName, operation: operation, requestOptions: test.requestOptions)
    check(command: command,
          callType: .write,
          method: .post,
          urlPath: "/1/indexes/testIndex/operation",
          queryItems: [.init(name: "testParameter", value: "testParameterValue")],
          body: operation.httpBody,
          requestOptions: test.requestOptions)
  }
  
  func testOperationCopyAll() {
    let operation: IndexOperation = .init(action: .copy, destination: test.anotherIndexName, scopes: nil)
    let command = Command.Index.Operation(indexName: test.indexName, operation: operation, requestOptions: test.requestOptions)
    check(command: command,
          callType: .write,
          method: .post,
          urlPath: "/1/indexes/testIndex/operation",
          queryItems: [.init(name: "testParameter", value: "testParameterValue")],
          body: operation.httpBody,
          requestOptions: test.requestOptions)
  }
  
  func testOperationCopyAllScopes() {
    let operation: IndexOperation = .init(action: .copy, destination: test.anotherIndexName, scopes: [.rules, .settings, .synonyms])
    let command = Command.Index.Operation(indexName: test.indexName, operation: operation, requestOptions: test.requestOptions)
    check(command: command,
          callType: .write,
          method: .post,
          urlPath: "/1/indexes/testIndex/operation",
          queryItems: [.init(name: "testParameter", value: "testParameterValue")],
          body: operation.httpBody,
          requestOptions: test.requestOptions)
  }
  
}
