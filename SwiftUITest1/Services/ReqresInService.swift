//
//  ReqresInService.swift
//  SwiftUITest1
//
//  Created by Patryk Strzemiecki on 26/11/2019.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation
#if canImport(Combine)
import Combine
#endif

protocol ReqresInService {
    var service: Service! { get set }
    func post(user: PostUserData) -> AnyPublisher<UserCreatedData, Error>
}

final class DefaultReqresInService: ReqresInService {
    var service: Service!
    static let base = URL(string: "https://reqres.in/api")!
    
    func post(user: PostUserData) -> AnyPublisher<UserCreatedData, Error> {
        var request = URLRequest(url: DefaultReqresInService.self.base.appendingPathComponent("users"))
        request.httpMethod = "POST"
        return run(request)
    }
}

private extension DefaultReqresInService {
    func run<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return service.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
