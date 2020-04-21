//
//  MockableFeatureTest.swift
//  StudyMockolo
//
//  Created by Takayuki Sei on 2020/04/21.
//  Copyright © 2020 takayuki sei. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// @mockable
protocol AssociatedTypeTest {
    associatedtype T
    associatedtype U
    func nyan(h: T) -> U
}

struct Nyassu {}

/// @mockable (typealias: T = String; U = Nyassu)
protocol AssociatedTypeSpecifyTest {
    associatedtype T
    associatedtype U
    func nyan(h: T) -> U
}

/// @mockable (rx: ob = PublishSubject; driver = BehaviorRelay; signal = PublishRelay; driver2 = BehaviorRelay)
protocol RxObservablesTest {
    var observable: Observable<String> { get }
    var driver: Driver<Int> { get }
    var signal: Signal<Nyassu> { get }
    var driver2: Observable<Int> { get }
    var signal2: Observable<Nyassu> { get }
}

/// @mockable (typealias: T = Int; rx: observable = ReplaySubject)
protocol MultiArgTypes {
    associatedtype T
    var observable: Observable<T> { get }
}
