//
//  NetworkLayerTest.swift
//  CharactersTests
//
//  Created by Mohamed Farid on 30/05/2024.
//

import XCTest
import Alamofire
@testable import Characters

class NetworkLayerTest: XCTestCase, HandleAlamofireResponse {
    
    // MARK: Handle Alamofire Response Tests
    
    func testSuccessAlamofireResponse() {
        guard let urlFromString = URL(string: "https://fakeURL.com") else {
            XCTFail("URL From String failed")
            return
        }
        let fakeUrlRequest = URLRequest(url: urlFromString)
        guard let url = fakeUrlRequest.url else {
            XCTFail("URL is null")
            return
        }
        guard let fakeResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("Fake Response is null")
            return
        }
        guard
            let charactersData = try? JSONEncoder().encode(CharactersResponse.fake()),
            let charactersResponse = try? self.handleAlamofireResponse(decoder: CharactersResponse.self,
                                                                       data: charactersData,
                                                                       urlrequest: fakeUrlRequest,
                                                                       response: fakeResponse)
        else { assertionFailure(); return }
        let subscription = MockAPI
            .getCharacters()
            .sink(receiveCompletion: { completion in
                guard case .failure = completion else { return }
                XCTFail("Fetching Video Failed")
            }, receiveValue: { charactersData in
                XCTAssertEqual(charactersData.results.first?.id, charactersResponse.results.first?.id)
            })
        subscription.cancel()
    }
    
    func testDecodingFailure() {
        guard let urlFromString = URL(string: "https://fakeURL.com") else {
            XCTFail("URL From String failed")
            return
        }
        let fakeUrlRequest = URLRequest(url: urlFromString)
        guard let url = fakeUrlRequest.url else {
            XCTFail("URL is null")
            return
        }
        guard let fakeResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            XCTFail("Fake Response is null")
            return
        }
        guard
            let charactersData = try? JSONEncoder().encode(CharactersResponse.fake())
        else { assertionFailure(); return }
        do {
            _ = try self.handleAlamofireResponse(decoder: Info.self,
                                                 data: charactersData,
                                                 urlrequest: fakeUrlRequest,
                                                 response: fakeResponse)
        } catch {
            XCTAssertEqual(error.localizedDescription, CustomError.decoding.errorDescription)
        }
    }
}

// MARK: - Request Builder & Handler Tests

extension NetworkLayerTest {
    
    // MARK: Test URL Request Builder
    
    func testRequestBuilder() {
        let request = CharactersRouter.getCharacters
        XCTAssertTrue(request.mainURL.contains(Constants.NetworkingConfigs.baseURL))
        XCTAssertEqual(
            request.headers[Constants.NetworkingConfigs.acceptHeaderKey],
            Constants.NetworkingConfigs.acceptHeaderValue
        )
        XCTAssertEqual(request.urlRequest.cachePolicy, .reloadIgnoringLocalCacheData)
    }
}
