//
//  UserRepository.swift
//  StudyMockolo
//
//  Created by Takayuki Sei on 2020/04/20.
//  Copyright © 2020 takayuki sei. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// @mockable
protocol UserRepository {
    var users: Driver<[User]> { get }
    func fetchUsers()
    func fetchUser(identifier: String) -> Observable<User>
}

class DefaultUserRepository: UserRepository {
    private let usersRelay = BehaviorRelay<[User]>(value: [])
    var users: Driver<[User]> {
        return usersRelay.asDriver()
    }
    
    func fetchUsers() {
        let users: [User] = [
            User(identifier: "hoge"),
            User(identifier: "fuga"),
            User(identifier: "nyassu"),
        ]
        
        usersRelay.accept(users)
    }
    
    func fetchUser(identifier: String) -> Observable<User> {
        return Observable.just(User(identifier: identifier))
    }
}
