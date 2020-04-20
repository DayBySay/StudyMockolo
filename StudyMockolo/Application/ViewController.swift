//
//  ViewController.swift
//  StudyMockolo
//
//  Created by Takayuki Sei on 2020/04/20.
//  Copyright © 2020 takayuki sei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(selectedItem: tableView.rx.itemSelected)
        viewModel.viewDidLoad()
        
        viewModel
            .users
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { row, element, cell in
                cell.textLabel?.text = element.identifier
        }
        .disposed(by: disposeBag)
        
        viewModel
            .selectedUser
            .emit(onNext: { (user) in
                print(user)
            })
            .disposed(by: disposeBag)
    }
}

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
