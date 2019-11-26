//
//  Models.swift
//  SwiftUITest1
//
//  Created by Patryk Strzemiecki on 26/11/2019.
//  Copyright © 2019 None. All rights reserved.
//

import Foundation

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
}

struct PostUserData: Codable {
    let name, job: String?
}

struct UserCreatedData: Codable, Identifiable {
    let id, createdAt: String?
}
