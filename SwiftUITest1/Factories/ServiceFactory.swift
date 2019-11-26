//
//  ServiceFactory.swift
//  SwiftUITest1
//
//  Created by Patryk Strzemiecki on 26/11/2019.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation

protocol ServiceFactory {
    static func makeGithubService() -> GithubService
    static func makeReqresInService() -> ReqresInService
}

final class DefaultServiceFactory {
    private init() {}
    
    static func makeGithubService() -> GithubService {
        var githubService = DefaultGithubService()
        var service = Service()
        service.session = URLSession.shared
        githubService.service = service
        return githubService
    }
    
    static func makeReqresInService() -> ReqresInService {
        let reqresInService = DefaultReqresInService()
        var service = Service()
        service.session = URLSession.shared
        reqresInService.service = service
        return reqresInService
    }
}
