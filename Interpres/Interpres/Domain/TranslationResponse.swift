//
//  TranslationResponse.swift
//  Interpres
//
//  Created by Guillem Sardà Parreu on 15/8/25.
//

struct TranslationResponseData: Decodable {
    var match: Int
    var translatedText: String
}

struct TranslationResponse: Decodable {
    var responseData: TranslationResponseData
}
