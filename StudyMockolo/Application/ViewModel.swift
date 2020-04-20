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
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

protocol ViewModelInputs {
    func viewDidLoad()
}

protocol ViewModelOutputs {
    var users: Driver<[User]> { get }
    var selectedUser: Signal<User> { get }
}

class ViewModel: ViewModelType, ViewModelInputs, ViewModelOutputs {
    private let usersUseCase: UsersUseCase
    private let fetchUsers = PublishRelay<()>()
    
    var inputs: ViewModelInputs { return self }
    var outputs: ViewModelOutputs { return self }
    
    var users: Driver<[User]>
    var selectedUser: Signal<User>
    
    init(selectedItem: ControlEvent<IndexPath>,
         usersUseCase: UsersUseCase = DefaultUsersUseCase()) {
        self.usersUseCase = usersUseCase
        users = fetchUsers
            .flatMapLatest({ (_) in
                return usersUseCase.fetchUsers().asSignal(onErrorSignalWith: Signal.empty())
            }).asDriver(onErrorDriveWith: Driver.empty())
        
        selectedUser = selectedItem.asSignal()
            .withLatestFrom(users.asSignal(onErrorSignalWith: Signal.empty()), resultSelector: { (indexPath, users) in
                return users[indexPath.row]
            })
    }
    
    func viewDidLoad() {
        fetchUsers.accept(())
    }
}
