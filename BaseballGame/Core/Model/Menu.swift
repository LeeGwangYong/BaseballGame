//
//  Menu.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/04.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum Menu: Int, CustomStringConvertible, CaseIterable {

    case inputData = 1
    case outputData
    case run

    var description: String {
        switch self {
        case .inputData:
            return "데이터 입력"
        case .outputData:
            return "데이터 출력"
        case .run:
            return "시합 시작"
        }
    }

}
