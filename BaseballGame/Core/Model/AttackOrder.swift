//
//  AttackOrder.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/04.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum AttackOrder: CaseIterable, CustomStringConvertible {

    case top
    case bottom

    var description: String {
        switch self {
        case .top:
            return "초"
        case .bottom:
            return "말"
        }
    }

    func toggled() -> Self {
        switch self {
        case .top:
            return .bottom
        case .bottom:
            return .top
        }
    }

}
