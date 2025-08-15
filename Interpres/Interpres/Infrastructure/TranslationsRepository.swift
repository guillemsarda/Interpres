//
//  TranslationsRepository.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 15/8/25.
//

import Foundation

extension URLSession: URLSessionProtocol {}

class TranslationsRepository {
    private let session: URLSessionProtocol
    private let TRANSLATION_API_URL: String
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
        if let translationApiUrl =  Bundle.main.object(forInfoDictionaryKey: "TRANSLATION_API_URL") as? String {
            self.TRANSLATION_API_URL = translationApiUrl
            return
        }
        self.TRANSLATION_API_URL = ""
    }
    
    func translate(word: String, source: String, target: String) async throws -> String {
        let queryParams = [
            URLQueryItem(name: "q", value: word),
            URLQueryItem(name: "langpair", value: "\(source)|\(target)")
        ]
        var urlComponents = URLComponents(string: TRANSLATION_API_URL)!
        urlComponents.queryItems = queryParams
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await self.session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let json = try JSONDecoder().decode(TranslationResponse.self, from: data)
        return json.responseData.translatedText
    }
}


