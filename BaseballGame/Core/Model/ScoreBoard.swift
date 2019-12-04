//
//  ScoreBoard.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

struct ScoreBoard {

    let hit: Int
    let out: Int

    init(hit: Int = 0,
         out: Int = 0) {
        self.hit = hit
        self.out = out
    }

}
