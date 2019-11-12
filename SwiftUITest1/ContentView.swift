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

@available(iOS 13.0, *)
struct MainNavigationView: View {
    var body: some View {
        VStack {
            NavigationView {
                ContentView()
                    .navigationBarTitle("Welcome")
            }
        }
    }
}

@available(iOS 13.0, *)
struct ContentView: View {
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var persons = ["Lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit", "Lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit"]
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    Text(NSLocalizedString("Header", comment: ""))
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
            List(persons.indices, id: \.self) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                    Text("\(self.persons[index])")
                }.transformEffect(CGAffineTransform(rotationAngle: 0.1))
            }.padding(30)
                .padding(.leading, -30)
        }
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
