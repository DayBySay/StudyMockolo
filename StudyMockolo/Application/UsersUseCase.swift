//
//  UsersUseCase.swift
//  StudyMockolo
//
//  Created by Takayuki Sei on 2020/04/20.
//  Copyright © 2020 takayuki sei. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// @mockable
protocol UsersUseCase {
    var users: Driver<[User]> { get }
    func fetchUsers()
}

class DefaultUsersUseCase: UsersUseCase {
    private let userRepository: UserRepository
    var users: Driver<[User]> {
        return userRepository.users
    }
    
    init(userRepository: UserRepository = DefaultUserRepository()) {
        self.userRepository = userRepository
    }
    
    func fetchUsers() {
        userRepository.fetchUsers()
    }
}
