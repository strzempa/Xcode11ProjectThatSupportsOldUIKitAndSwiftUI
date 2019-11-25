//
//  AppCoordinator.swift
//  SwiftUITest1
//
//  Created by Patryk Strzemiecki on 12/11/2019.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

final class AppCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AppCoordinator {
    func start() {
        let collectionViewController = SomeViewController()
        var githubService = DefaultGithubService()
        var service = Service()
        service.session = URLSession.shared
        githubService.service = service
        collectionViewController.githubService = githubService
        navigationController.pushViewController(collectionViewController, animated: false)
    }
}
