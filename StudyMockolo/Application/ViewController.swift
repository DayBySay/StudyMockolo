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
        viewModel = ViewModel()
        viewModel.viewDidLoad()
        
        viewModel
            .users
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { row, element, cell in
                cell.textLabel?.text = element.identifier
        }
        .disposed(by: disposeBag)
    }
}

protocol ViewModelType {
    var users: Driver<[User]> { get }
    func viewDidLoad()
}

class ViewModel: ViewModelType {
    private let userRepo: UserRepository
    
    var users: Driver<[User]> {
        return userRepo.users
    }
    
    init(userRepository: UserRepository = DefaultUserRepository()) {
        userRepo = userRepository
    }
    
    func viewDidLoad() {
        userRepo.fetchUsers()
    }
}
