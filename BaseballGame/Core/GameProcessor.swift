//
//  GameProcessor.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

func process(hitterState: HitterState, progress: GameProgress) -> GameProgress {
    switch hitterState {
    case .hit:
        output(types: [.hit, .nextHitter])
        return hitted(progress)
    case .ball:
        output(.ball)
        return balled(progress)
    case .strike:
        output(.strike)
        return striked(progress)
    }
}

private func hitted(_ progress: GameProgress) -> GameProgress {
    return GameProgress(hitter: Hitter(),
                        scoreBoard: ScoreBoard(hit: progress.scoreBoard.hit + 1,
                                               out: progress.scoreBoard.out),
                        isOvered: progress.isOvered)
}

private let maximumBall = 4
private func balled(_ progress: GameProgress) -> GameProgress {
    let hitter = Hitter(strike: progress.hitter.strike,
                        ball: progress.hitter.ball + 1)
    return hitter.ball >= maximumBall ?
        process(hitterState: .hit, progress: progress) : GameProgress(hitter: hitter, scoreBoard: progress.scoreBoard, isOvered: progress.isOvered)
}

private let maximumStrike = 3
private let maximumOut = 3
private func striked(_ progress: GameProgress) -> GameProgress {
    let hitter = Hitter(strike: progress.hitter.strike + 1,
                        ball: progress.hitter.ball)
    if hitter.strike >= maximumStrike {
        let scoreBoard = ScoreBoard(hit: progress.scoreBoard.hit, out: progress.scoreBoard.out + 1)
        let isGameOvered = scoreBoard.out >= maximumOut
        isGameOvered ? output(.out) : output(types: [.out, .nextHitter])
        return GameProgress(hitter: Hitter(),
                            scoreBoard: scoreBoard,
                            isOvered: isGameOvered)
    } else {
        return GameProgress(hitter: hitter,
                            scoreBoard: progress.scoreBoard,
                            isOvered: progress.isOvered)
    }
}
