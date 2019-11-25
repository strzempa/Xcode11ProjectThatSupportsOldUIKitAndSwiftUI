//
//  GithubService.swift
//  SwiftUITest1
//
//  Created by Patryk Strzemiecki on 25/11/2019.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation
#if canImport(Combine)
import Combine
#endif

protocol GithubService {
    var service: Service! { get set }
    func fetchRepos(username: String) -> AnyPublisher<[Repository], Error>
}

struct DefaultGithubService: GithubService {
    var service: Service!
    static let base = URL(string: "https://api.github.com")!
}

extension DefaultGithubService {
    func fetchRepos(username: String) -> AnyPublisher<[Repository], Error> {
        return run(URLRequest(url: DefaultGithubService.self.base.appendingPathComponent("users/\(username)/repos")))
    }
}

private extension DefaultGithubService {
    func run<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return service.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

struct Repository: Codable {
    let id: Int
    let name: String
}
