//
//  HitterStateError.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/04.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum HitterStateError: LocalizedError {

    case isNoMatchingHitterState

    var errorDescription: String? {
        switch self {
        case .isNoMatchingHitterState:
            return "알맞는 HitterState가 존재하지 않습니다."
        }
    }

}
