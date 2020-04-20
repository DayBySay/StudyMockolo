///
/// @Generated by Mockolo
///



import Foundation
import RxCocoa
import RxSwift
import UIKit
@testable import StudyMockolo


class UserRepositoryMock: UserRepository {
    init() { }
    init(users: Driver<[User]>) {
        self._users = users
    }

    var usersSetCallCount = 0
    private var _users: Driver<[User]>!  { didSet { usersSetCallCount += 1 } }
    var users: Driver<[User]> {
        get { return _users }
        set { _users = newValue }
    }

    var fetchUsersCallCount = 0
    var fetchUsersHandler: (() -> ())?
    func fetchUsers()  {
        fetchUsersCallCount += 1
        if let fetchUsersHandler = fetchUsersHandler {
            fetchUsersHandler()
        }
        
    }

    var fetchUserCallCount = 0
    var fetchUserHandler: ((String) -> (Observable<User>))?
    func fetchUser(identifier: String) -> Observable<User> {
        fetchUserCallCount += 1
        if let fetchUserHandler = fetchUserHandler {
            return fetchUserHandler(identifier)
        }
        return Observable<User>.empty()
    }
}

class ViewModelTypeMock: ViewModelType {
    init() { }
    init(users: Driver<[User]>, selectedUser: Signal<User>) {
        self._users = users
        self._selectedUser = selectedUser
    }

    var usersSetCallCount = 0
    private var _users: Driver<[User]>!  { didSet { usersSetCallCount += 1 } }
    var users: Driver<[User]> {
        get { return _users }
        set { _users = newValue }
    }

    var selectedUserSetCallCount = 0
    private var _selectedUser: Signal<User>!  { didSet { selectedUserSetCallCount += 1 } }
    var selectedUser: Signal<User> {
        get { return _selectedUser }
        set { _selectedUser = newValue }
    }

    var viewDidLoadCallCount = 0
    var viewDidLoadHandler: (() -> ())?
    func viewDidLoad()  {
        viewDidLoadCallCount += 1
        if let viewDidLoadHandler = viewDidLoadHandler {
            viewDidLoadHandler()
        }
        
    }
}

class UsersUseCaseMock: UsersUseCase {
    init() { }
    init(users: Driver<[User]>) {
        self._users = users
    }

    var usersSetCallCount = 0
    private var _users: Driver<[User]>!  { didSet { usersSetCallCount += 1 } }
    var users: Driver<[User]> {
        get { return _users }
        set { _users = newValue }
    }

    var fetchUsersCallCount = 0
    var fetchUsersHandler: (() -> ())?
    func fetchUsers()  {
        fetchUsersCallCount += 1
        if let fetchUsersHandler = fetchUsersHandler {
            fetchUsersHandler()
        }
        
    }
}

