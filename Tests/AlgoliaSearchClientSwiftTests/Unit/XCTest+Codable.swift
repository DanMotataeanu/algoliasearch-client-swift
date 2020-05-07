//
//  XCTest+Codable.swift
//  
//
//  Created by Vladislav Fitc on 11.03.2020.
//

import Foundation
import XCTest
@testable import AlgoliaSearchClientSwift

func AssertEncodeDecode<T: Codable>(_ value: T, _ rawValue: JSON, file: StaticString = #file, line: UInt = #line) throws {
  try AssertEncode(value, expected: rawValue, file: file, line: line)
  try AssertDecode(rawValue, expected: value, file: file, line: line)
}

func AssertDecode<T: Codable>(_ input: JSON, expected: T, file: StaticString = #file, line: UInt = #line) throws {

  let encoder = JSONEncoder()
  encoder.dateEncodingStrategy = .swiftAPIClient
  let data = try encoder.encode(expected)

  let jsonDecoder = JSONDecoder()
  jsonDecoder.dateDecodingStrategy = .swiftAPIClient
  let expectedJSON = try jsonDecoder.decode(JSON.self, from: data)

  XCTAssertEqual(input, expectedJSON, file: file, line: line)
}

@discardableResult func AssertDecode<T: Decodable>(jsonFilename filename: String, expected: T.Type, file: StaticString = #file, line: UInt = #line) throws -> T {
  let data = try Data(filename: filename)
  return try JSONDecoder().decode(T.self, from: data)
}

func AssertEncode<T: Encodable>(_ value: T, expected: JSON, file: StaticString = #file, line: UInt = #line) throws {

  let encoder = JSONEncoder()
  encoder.dateEncodingStrategy = .swiftAPIClient
  let valueData = try encoder.encode(value)

  let jsonDecoder = JSONDecoder()
  jsonDecoder.dateDecodingStrategy = .swiftAPIClient
  let jsonFromValue = try jsonDecoder.decode(JSON.self, from: valueData)

  XCTAssertEqual(jsonFromValue, expected, file: file, line: line)
}

func AssertEquallyEncoded<A: Encodable, B: Encodable>(_ l: A, _ r: B, file: StaticString = #file, line: UInt = #line) throws {
  let encoder = JSONEncoder()
  encoder.dateEncodingStrategy = .swiftAPIClient
  let lData = try encoder.encode(l)
  let rData = try encoder.encode(r)
  XCTAssertEqual(lData, rData, file: file, line: line)
}

func AssertThrowsNotFound<T>(_ body: @autoclosure () throws -> T, file: StaticString = #file, line: UInt = #line) throws {
  do {
    _ = try body()
    XCTFail("Expected Not Found error", file: file, line: line)
  } catch let error {
    guard let httpError = error as? HTTPError, httpError.statusCode == 404 else {
      throw error
    }
  }
}
