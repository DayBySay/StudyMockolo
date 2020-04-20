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
