//
//  ScoreBoard.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

struct ScoreBoard {

    let hit: UInt
    let out: UInt

    init(hit: UInt = 0,
         out: UInt = 0) {
        self.hit = hit
        self.out = out
    }

}
