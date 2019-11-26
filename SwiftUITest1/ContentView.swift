//
//  ContentView.swift
//  SwiftUITest1
//
//  Created by Patryk Strzemiecki on 08/11/2019.
//  Copyright © 2019 None. All rights reserved.
//

#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(Combine)
import Combine
#endif

@available(iOS 13.0, *)
struct MainNavigationView: View {
    var githubService: GithubService!
    var reqresInService: ReqresInService!
    
    init(githubService: GithubService,
         reqresInService: ReqresInService) {
        self.githubService = githubService
        self.reqresInService = reqresInService
    }
    
    var body: some View {
        VStack {
            NavigationView {
                ContentView(githubService: githubService,
                            reqresInService: reqresInService)
                    .navigationBarTitle("Welcome")
            }
        }
    }
}

@available(iOS 13.0, *)
struct ContentView: View {
    var githubService: GithubService!
    var reqresInService: ReqresInService!
    
    @State var tasks: AnyCancellable?
    @State var items: [Any] = [] {
        didSet {
            tasks?.cancel()
            tasks = nil /// just to show that it finished running on the UI
        }
    }
    
    init(githubService: GithubService,
         reqresInService: ReqresInService) {
        self.githubService = githubService
        self.reqresInService = reqresInService
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    Text(NSLocalizedString(tasks.debugDescription, comment: ""))
                        .foregroundColor(.white)
                        .padding()
                        .padding(.leading, 60)
                        .padding(.trailing, 60)
                }
                .padding(.top, 10)
                .fixedSize()
                .foregroundColor(.blue)
                .transformEffect(CGAffineTransform(rotationAngle: -0.1))
            }
            Button(
                action: { self.fetchData() },
                label: { Text("Fetch data") }
            )
            List(items.indices, id: \.self) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                    Text("\((self.items[index] as? Repository)?.name ?? (self.items[index] as? UserCreatedData)?.createdAt ?? "")")
                }//.transformEffect(CGAffineTransform(rotationAngle: 0.1))
            }.padding(30)
                .padding()
        }
    }
    
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
            .sink(receiveCompletion: { _ in
            },
                  receiveValue: { [self] data in
                    self.items += [data.0.0, data.0.1]
                    self.items += Array(data.1.0.prefix(5) + data.1.1.prefix(5))
            })
    }
    
    func cancelTasks() {
        tasks?.cancel()
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(githubService: DefaultServiceFactory.makeGithubService(),
                    reqresInService: DefaultServiceFactory.makeReqresInService())
    }
}
