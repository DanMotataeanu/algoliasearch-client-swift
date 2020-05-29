//
//  Command+ABTest.swift
//  
//
//  Created by Vladislav Fitc on 28/05/2020.
//

import Foundation

extension Command {

  enum ABTest {
    
    struct Add: AlgoliaCommand {
      
      let callType: CallType = .write
      let urlRequest: URLRequest
      let requestOptions: RequestOptions?
      
      init(abTest: AlgoliaSearchClientSwift.ABTest, requestOptions: RequestOptions?) {
        self.requestOptions = requestOptions
        self.urlRequest = .init(method: .post, path: Path.ABTestsV2, body: abTest.httpBody, requestOptions: self.requestOptions)
      }
      
    }
    
    struct Get: AlgoliaCommand {
      
      let callType: CallType = .read
      let urlRequest: URLRequest
      let requestOptions: RequestOptions?
      
      init(abTestID: ABTestID, requestOptions: RequestOptions?) {
        self.requestOptions = requestOptions
        self.urlRequest = .init(method: .get, path: .ABTestsV2 >>> ABTestRoute.ABTestID(abTestID), requestOptions: self.requestOptions)
      }
      
    }

    struct Stop: AlgoliaCommand {
      
      let callType: CallType = .write
      let urlRequest: URLRequest
      let requestOptions: RequestOptions?
      
      init(abTestID: ABTestID, requestOptions: RequestOptions?) {
        self.requestOptions = requestOptions
        self.urlRequest = .init(method: .post, path: .ABTestsV2 >>> .ABTestID(abTestID) >>> ABTestCompletion.stop, requestOptions: self.requestOptions)
      }

    }
    
    struct Delete: AlgoliaCommand {
      
      let callType: CallType = .write
      let urlRequest: URLRequest
      let requestOptions: RequestOptions?
      
      init(abTestID: ABTestID, requestOptions: RequestOptions?) {
        self.requestOptions = requestOptions
        self.urlRequest = .init(method: .delete, path: .ABTestsV2 >>> ABTestRoute.ABTestID(abTestID), requestOptions: self.requestOptions)
      }

    }
    
    struct List: AlgoliaCommand {
      
      let callType: CallType = .read
      let urlRequest: URLRequest
      let requestOptions: RequestOptions?
      
      init(page: Int?, hitsPerPage: Int?, requestOptions: RequestOptions?) {
        self.requestOptions = requestOptions.updateOrCreate(
          [
            .offset: page.flatMap(String.init),
            .limit: hitsPerPage.flatMap(String.init)
          ])
        self.urlRequest = .init(method: .get, path: Path.ABTestsV2, requestOptions: self.requestOptions)
      }

    }
    
  }

}
