//
//  Hoge.swift
//  StudyMockolo
//
//  Created by Takayuki Sei on 2020/04/20.
//  Copyright © 2020 takayuki sei. All rights reserved.
//

import Foundation

/// @mockable
protocol Hoge {
    var prop1: Int { get }
    var prop2: String { get set }
    func hogeFun()
    func fugaFunc() -> Bool
}
