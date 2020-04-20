//
//  StudyMockoloTests.swift
//  StudyMockoloTests
//
//  Created by Takayuki Sei on 2020/04/20.
//  Copyright © 2020 takayuki sei. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import StudyMockolo

class StudyMockoloTests: XCTestCase {
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    func testViewModelFetchUsers() {
        let userRepositoryMock = UserRepositoryMock()
        userRepositoryMock.fetchUsersHandler = {
            return Observable<[User]>.just([
                User(identifier: "nyan"),
                User(identifier: "nyassu"),
                User(identifier: "nyossu"),
            ])
        }
        let users = scheduler.createObserver([User].self)
        let viewModel = ViewModel(itemSelected: Signal.empty(),
                                  usersUseCase: DefaultUsersUseCase(userRepository: userRepositoryMock))
        viewModel.outputs.users
            .drive(users).disposed(by: disposeBag)
        
        scheduler.scheduleAt(10, action: viewModel.inputs.viewDidLoad)
        scheduler.scheduleAt(20, action: viewModel.inputs.viewDidLoad)
        scheduler.scheduleAt(30) {
            userRepositoryMock.fetchUsersHandler = {
                return Observable<[User]>.just([
                    User(identifier: "nyan")
                ])
            }
        }
        scheduler.scheduleAt(40, action: viewModel.inputs.viewDidLoad)
        scheduler.start()
        
        XCTAssertEqual(users.events, [
            .next(10, [
                User(identifier: "nyan"),
                User(identifier: "nyassu"),
                User(identifier: "nyossu"),
            ]),
            .next(20, [
                User(identifier: "nyan"),
                User(identifier: "nyassu"),
                User(identifier: "nyossu"),
            ]),
            .next(40, [
                User(identifier: "nyan"),
            ]),
        ])
    }
    
    func testViewModelSelectedUsers() {
        let usecaseMock = UsersUseCaseMock()
        usecaseMock.fetchUsersHandler = {
            return Observable<[User]>.just([
                User(identifier: "nyan"),
                User(identifier: "nyassu"),
                User(identifier: "nyossu"),
            ])
        }
        let select = PublishRelay<IndexPath>()
        let selectedUser = scheduler.createObserver(User.self)
        let viewModel = ViewModel(itemSelected: select.asSignal(),
                                  usersUseCase: usecaseMock)
        viewModel.outputs.selectedUser
            .emit(to: selectedUser).disposed(by: disposeBag)
        
        scheduler.scheduleAt(5) {
            select.accept(IndexPath(item: 0, section: 0))
        }
        scheduler.scheduleAt(10, action: viewModel.inputs.viewDidLoad)
        scheduler.scheduleAt(20) {
            select.accept(IndexPath(item: 0, section: 0))
        }
        scheduler.start()
        
        XCTAssertEqual(selectedUser.events, [
            .next(20, User(identifier: "nyan"))
        ])
    }
}
