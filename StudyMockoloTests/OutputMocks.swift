///
/// @Generated by Mockolo
///



import Foundation
import RxCocoa
import RxSwift
@testable import StudyMockolo


class HogeMock: Hoge {
    init() { }
    init(prop1: Int = 0, prop2: String = "") {
        self.prop1 = prop1
        self.prop2 = prop2
    }

    var prop1SetCallCount = 0
    var prop1: Int = 0 { didSet { prop1SetCallCount += 1 } }

    var prop2SetCallCount = 0
    var prop2: String = "" { didSet { prop2SetCallCount += 1 } }

    var hogeFunCallCount = 0
    var hogeFunHandler: (() -> ())?
    func hogeFun()  {
        hogeFunCallCount += 1
        if let hogeFunHandler = hogeFunHandler {
            hogeFunHandler()
        }
        
    }

    var fugaFuncCallCount = 0
    var fugaFuncHandler: (() -> (Bool))?
    func fugaFunc() -> Bool {
        fugaFuncCallCount += 1
        if let fugaFuncHandler = fugaFuncHandler {
            return fugaFuncHandler()
        }
        return false
    }
}

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

