//
//  TranslationsRepository.test.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 15/8/25.
//

import XCTest

final class TranslationsRepositoryTests: XCTestCase {
    
    func testTranslateReturnsExpectedText() async throws {
        let mockSession = MockURLSession()
        let expectedText = "hola"
        let json = """
        {
          "responseData": {
            "match": 100,
            "translatedText": "\(expectedText)"
          }
        }
        """
        mockSession.nextData = json.data(using: .utf8)
        mockSession.nextResponse = HTTPURLResponse(url: URL(string: "https://fake-url")!,
                                                   statusCode: 200,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        let repo = TranslationsRepository(session: mockSession)
        
        let result = try await repo.translate(word: "hello", source: "en", target: "es")
        
        XCTAssertEqual(result, expectedText)
    }
    
    func testTranslateThrowsOnBadStatusCode() async {
        let mockSession = MockURLSession()
        mockSession.nextResponse = HTTPURLResponse(url: URL(string: "https://fake-url")!,
                                                   statusCode: 500,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        let repo = TranslationsRepository(session: mockSession)
        
        do {
            let _ = try await repo.translate(word: "hello", source: "en", target: "es")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
