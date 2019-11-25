//
//  SomeViewController.swift
//  SwiftUITest1
//
//  Created by Patryk Strzemiecki on 12/11/2019.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit
#if canImport(Combine)
import Combine
#endif

final class SomeViewController: UIViewController {
    var githubService: GithubService!
    
    private var token: AnyCancellable?
    private var repos: [Repository]? {
        didSet {
            label.text = repos?
                .compactMap { $0.name }
                .joined(separator: "\n")
        }
    }
    
    private lazy var label: UILabel = {
        let someLabel = UILabel(frame: CGRect.zero)
        someLabel.numberOfLines = 0
        someLabel.textAlignment = .center
        return someLabel
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        setupLabel()
        
        fetchRepos()
    }
}

private extension SomeViewController {
    func fetchRepos() {
        let token1 = githubService
            .fetchRepos(username: "strzempa")
        
        let token2 = githubService
            .fetchRepos(username: "kastiglione")
        
        token = Publishers.Zip(token1, token2)
            .sink(receiveCompletion: { status in
                print("finished fetchRepos with status: \(status)")
            },
                  receiveValue: { [weak self] repos1, repos2 in
                    self?.repos = repos1 + repos2.prefix(5)
            })
    }
    
    func cancelTasks() {
        token?.cancel()
    }
    
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
