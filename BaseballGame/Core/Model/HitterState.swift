//
//  HitterState.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum HitterState: Int, CaseIterable, CustomStringConvertible {

    case hit
    case strike
    case ball
    case out

    var description: String {
        switch self {
        case .hit:
            return "안타!"
        case .strike:
            return "스트라이크!"
        case .ball:
            return "볼!"
        case .out:
            return "아웃!"
        }
    }
    
}
