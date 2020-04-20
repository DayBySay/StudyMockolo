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
    private var viewModel: ViewModelType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        viewModel
            .outputs
            .users
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { row, element, cell in
                cell.textLabel?.text = element.identifier
            }
            .disposed(by: disposeBag)

        viewModel
            .outputs
            .selectedUser
            .emit(onNext: { (user) in
                print(user)
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.inputs.select(indexPath: indexPath)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.viewDidLoad()
        
    }
}
