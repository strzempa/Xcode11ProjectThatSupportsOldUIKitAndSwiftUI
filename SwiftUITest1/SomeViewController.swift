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
    var reqresInService: ReqresInService!
    
    private var tasks: AnyCancellable?
    private var repos: [Repository]? {
        didSet {
            label.text = repos?
                .compactMap { $0.name }
                .joined(separator: "\n")
        }
    }
    private var users: [UserCreatedData]? {
        didSet {
            let usersText = users?
                .compactMap { "id: \($0.id ?? "") createdAt: \($0.createdAt ?? "")" }
                .joined(separator: "\n")
            guard let text = usersText else {
                return
            }
            label.text = "\(label.text ?? "") \n\n \(text)"
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
        
        fetchData()
    }
}

private extension SomeViewController {
    func fetchData() {
        let fetchReposTask1 = githubService
            .fetchRepos(username: "strzempa")
        
        let fetchReposTask2 = githubService
            .fetchRepos(username: "kastiglione")
        
        let postUserTask1 = reqresInService
            .post(user: PostUserData(name: "morpheus", job: "leader"))

        let postUserTask2 = reqresInService
            .post(user: PostUserData(name: "alex", job: "jobb"))
        
        tasks = Publishers.Zip(Publishers.Zip(postUserTask1, postUserTask2),
                                   Publishers.Zip(fetchReposTask1, fetchReposTask2))
            .sink(receiveCompletion: { status in
                DispatchQueue.main.async { [weak self] in
                    self?.title = "\(status)"
                }
            },
                  receiveValue: { [weak self] data in
                    self?.repos = Array(data.1.0.prefix(5) + data.1.1.prefix(5))
                    self?.users = [data.0.0, data.0.1]
            })
    }
    
    func cancelTasks() {
        tasks?.cancel()
    }
    
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
