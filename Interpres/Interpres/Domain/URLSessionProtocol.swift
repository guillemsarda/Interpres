//
//  File.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 15/8/25.
//

import Foundation


protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
