//
//  UserManagement.swift
//  pc
//
//  Created by Matthew Smith on 10/15/24.
//

import Foundation

class UserManagement: ObservableObject {
    @Published var user: UserModel
    
    init(user: UserModel) {
        self.user = user
    }
}
