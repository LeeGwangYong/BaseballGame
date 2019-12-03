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
    output(.gameStart)
    output(.firstHitter)
    output(.empty)
    recursivelyRun(gameProgress)
}

private func recursivelyRun(hitterState: HitterState = hitterState(),
                            _ progress: GameProgress) {
    guard !progress.isOvered else {
        output(.finalScore(scoreboard: progress.scoreBoard))
        output(.gameOver)
        return
    }
    let processedProgress = process(hitterState: hitterState, progress: progress)
    output(.currentProgress(progress: processedProgress))
    output(.empty)
    recursivelyRun(processedProgress)
}
