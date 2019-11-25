//
//  Service.swift
//  SwiftUITest1
//
//  Created by Patryk Strzemiecki on 25/11/2019.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation
#if canImport(Combine)
import Combine
#endif

struct Service {
    var session: URLSession!
    private let decoder: JSONDecoder = JSONDecoder()
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Codable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
//                print(String(data: result.data, encoding: .utf8) ?? "")
                let value = try self.decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
