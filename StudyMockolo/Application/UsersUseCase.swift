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
    func fetchUsers() -> Observable<[User]>
}

class DefaultUsersUseCase: UsersUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository = DefaultUserRepository()) {
        self.userRepository = userRepository
    }
    
    func fetchUsers() -> Observable<[User]> {
        return userRepository.fetchUsers()
    }
}
