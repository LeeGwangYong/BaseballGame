//
//  Hitter.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

struct Hitter {

    let strike: Int
    let ball: Int

    init(strike: Int = 0,
         ball: Int = 0) {
        self.strike = strike
        self.ball = ball
    }

}
