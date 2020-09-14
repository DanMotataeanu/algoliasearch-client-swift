//
//  HighlightedStringTests.swift
//  
//
//  Created by Vladislav Fitc on 05/06/2020.
//

import Foundation
import XCTest
@testable import AlgoliaSearchClient

class HighlightedStringTests: XCTestCase {
  
    func testWithDecodedString() throws {

      let expectedHighlightedPart = "rennais"
      
      let inlineString = "VIDÉO. Des CRS déployés devant un lycée <em>rennais</em> pour les épreuves anticipées du bac"

      let stringData = try Data(filename: "HighlightedString.json")
      let decodedString = try XCTUnwrap(String(data: stringData, encoding: .utf8))

      let inlineHiglighted = HighlightedString(string: inlineString)
      let decodedHighlighted = HighlightedString(string: decodedString)
      
      func extractHighlightedPart(from title: HighlightedString) -> String {
        let highlightedRange = title.taggedString.taggedRanges.first!
        let highlightedPart = title.taggedString.output[highlightedRange]
        return String(highlightedPart)
      }
      
      XCTAssertEqual(expectedHighlightedPart, extractHighlightedPart(from: inlineHiglighted))
      XCTAssertEqual(expectedHighlightedPart, extractHighlightedPart(from: decodedHighlighted))

    }
  
    struct MarkupString: Codable {
      let source: String
      let markup: HighlightedString
    }
  
    func testWithHTMLString() throws {
      let data = try Data(filename: "HighlightedHTML.json")
      let searchResponse = try JSONDecoder().decode(MarkupString.self, from: data)
      let searchResponseJSON = try JSON(searchResponse)
      print(searchResponseJSON)
    }

}

