//
//  GameProgress.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

struct GameProgress {

    let hitter: Hitter
    let scoreBoard: ScoreBoard
    let score: Int
    let memberIndex: Int
    let isOvered: Bool
    private let numberOfMembers = 9

    init(hitter: Hitter = Hitter(),
         scoreBoard: ScoreBoard = ScoreBoard(),
         score: Int = 0,
         memberIndex: Int,
         isOvered: Bool = false) {
        self.hitter = hitter
        self.scoreBoard = scoreBoard
        self.score = score
        self.memberIndex = memberIndex % numberOfMembers
        self.isOvered = isOvered
    }

}
