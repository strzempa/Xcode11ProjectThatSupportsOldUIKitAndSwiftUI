//
//  SomeViewController.swift
//  SwiftUITest1
//
//  Created by Patryk Strzemiecki on 12/11/2019.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit

final class SomeViewController: UIViewController {
    lazy var label: UILabel = {
        let someLabel = UILabel(frame: CGRect.zero)
        someLabel.text = "iOS <13 style"
        someLabel.textAlignment = .center
        return someLabel
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        setupLabel()
    }
}

private extension SomeViewController {
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
