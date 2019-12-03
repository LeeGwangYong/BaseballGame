//
//  GameRunner.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

func run() {
    let hitter = Hitter()
    let scoreBoard = ScoreBoard()
    let gameProgress = GameProgress(hitter: hitter, scoreBoard: scoreBoard, isOvered: false)
    recursivelyRun(gameProgress)
}

private func recursivelyRun(_ progress: GameProgress) {
    guard !progress.isOvered else {
        return
    }
    // Process
}
