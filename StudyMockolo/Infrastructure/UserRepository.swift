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
    func fetchUsers() -> Observable<[User]>
}

class DefaultUserRepository: UserRepository {
    func fetchUsers() -> Observable<[User]> {
        return Observable.create { (observer) -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                let users: [User] = [
                    User(identifier: "hoge"),
                    User(identifier: "fuga"),
                    User(identifier: "nyassu"),
                ]
                observer.onNext(users)
            }
            
            return Disposables.create()
        }
    }
    
    func fetchUser(identifier: String) -> Observable<User> {
        return Observable.just(User(identifier: identifier))
    }
}
