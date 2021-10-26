//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Christophe Expleo on 20/10/2021.
//

import Foundation

final class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.apple.com")!,
                                            statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.apple.com")!,
                                            statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkError: Error {}
    static let networkError = NetworkError()

    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let incorrectData = "error".data(using: .utf8)!
}
