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
        collectionViewController.githubService = DefaultServiceFactory.makeGithubService()
        collectionViewController.reqresInService = DefaultServiceFactory.makeReqresInService()
        navigationController.pushViewController(collectionViewController, animated: false)
    }
}
