//
//  Client+Logs.swift
//  
//
//  Created by Vladislav Fitc on 18/04/2020.
//

import Foundation

public extension Client {

  // MARK: - Get logs

  /**
   Get the logs of the latest search and indexing operations.
   You can retrieve the logs of your last 1,000 API calls. It is designed for immediate, real-time debugging.
   All logs older than 7 days will be removed and won’t be accessible anymore from the API.
   This API is counted in your operation quota but is not logged.

   - Parameter page: Specify the first entry to retrieve (0-based, 0 is the most recent log entry).
   - Parameter hitsPerPage: Specify the maximum number of entries to retrieve starting at the page. Maximum allowed value: 1,000.
   - Parameter logType: Type of logs to retrieve.
   - Parameter requestOptions: Configure request locally with RequestOptions
   - Parameter completion: Result completion
   - Returns: Launched asynchronous operation
   */
  @discardableResult func getLogs(page: Int? = nil, hitsPerPage: Int? = nil, type: LogType = .all, requestOptions: RequestOptions? = nil, completion: @escaping ResultCallback<[Log]>) -> Operation {
    let command = Command.Advanced.GetLogs(indexName: nil, page: page, hitsPerPage: hitsPerPage, logType: type, requestOptions: requestOptions)
    return execute(command, transform: \LogsResponse.logs, completion: completion)
  }

  /**
   Get the logs of the latest search and indexing operations.
   You can retrieve the logs of your last 1,000 API calls. It is designed for immediate, real-time debugging.
   All logs older than 7 days will be removed and won’t be accessible anymore from the API.
   This API is counted in your operation quota but is not logged.
   
   - Parameter page: Specify the first entry to retrieve (0-based, 0 is the most recent log entry).
   - Parameter hitsPerPage: Specify the maximum number of entries to retrieve starting at the page. Maximum allowed value: 1,000.
   - Parameter logType: Type of logs to retrieve.
   - Parameter requestOptions: Configure request locally with RequestOptions
   - Returns: LogsResponse  object
   */
  @discardableResult func getLogs(page: Int? = nil, hitsPerPage: Int? = nil, type: LogType = .all, requestOptions: RequestOptions? = nil) throws -> [Log] {
    let command = Command.Advanced.GetLogs(indexName: nil, page: page, hitsPerPage: hitsPerPage, logType: type, requestOptions: requestOptions)
    return try execute(command, transform: \LogsResponse.logs)
  }

}
