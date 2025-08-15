//
//  MockURLSession.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 15/8/25.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = nextError {
            throw error
        }
        return (nextData ?? Data(), nextResponse
                ?? HTTPURLResponse(
                    url: request.url!, statusCode: 200,
                    httpVersion: nil,
                    headerFields: nil
                )!
        )
    }
}
