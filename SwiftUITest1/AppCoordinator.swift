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
        navigationController.pushViewController(collectionViewController, animated: false)
    }
}
