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

func AssertDecode<T: Decodable>(jsonFilename filename: String, expected: T.Type, file: StaticString = #file, line: UInt = #line) {
  do {
    let data = try Data(filename: filename)
    XCTAssertNoThrow(try JSONDecoder().decode(T.self, from: data))
  } catch _ {
    XCTFail("Impossible to read json file with name \(filename)")
  }
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
