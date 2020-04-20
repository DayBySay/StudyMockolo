//
//  ViewModel.swift
//  StudyMockolo
//
//  Created by Takayuki Sei on 2020/04/20.
//  Copyright © 2020 takayuki sei. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// @mockable
protocol ViewModelType {
    var users: Driver<[User]> { get }
    var selectedUser: Signal<User> { get }
    func viewDidLoad()
}

class ViewModel: ViewModelType {
    private let usersUseCase: UsersUseCase
    
    var users: Driver<[User]> {
        return usersUseCase.users
    }
    var selectedUser: Signal<User>
    
    init(selectedItem: ControlEvent<IndexPath>,
         usersUseCase: UsersUseCase = DefaultUsersUseCase()) {
        self.usersUseCase = usersUseCase
        selectedUser = selectedItem.asSignal()
            .withLatestFrom(usersUseCase.users.asSignal(onErrorSignalWith: Signal.empty()), resultSelector: { (indexPath, users) in
                return users[indexPath.row]
            })
    }
    
    func viewDidLoad() {
        usersUseCase.fetchUsers()
    }
}
