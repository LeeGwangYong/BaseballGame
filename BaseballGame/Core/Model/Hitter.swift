//
//  Hitter.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

struct Hitter {

    let strike: UInt
    let ball: UInt

    init(strike: UInt = 0,
         ball: UInt = 0) {
        self.strike = strike
        self.ball = ball
    }

}
