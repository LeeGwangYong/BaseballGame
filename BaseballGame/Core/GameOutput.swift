//
//  GameOutput.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum OutputType: CustomStringConvertible {
    case gameStart
    case gameOver

    case firstHitter
    case nextHitter

    case hit
    case ball
    case strike
    case out

    case currentProgress(progress: GameProgress)
    case finalScore(scoreboard: ScoreBoard)

    case empty

    var description: String {
        switch self {
        case .gameStart:
            return "신나는 야구 게임!"
        case .gameOver:
            return "GAME OVER"
        case .firstHitter:
            return "첫 번째 타자가 타석에 입장했습니다."
        case .nextHitter:
            return "다음 타자가 타석에 입장했습니다."
        case .hit:
            return "안타!"
        case .ball:
            return "볼!"
        case .strike:
            return "스트라이크!"
        case .out:
            return "아웃!"
        case .currentProgress(let progress):
            return "\(progress.hitter.strike)S, \(progress.hitter.ball)B, \(progress.scoreBoard.out)O"
        case .finalScore(let scoreboard):
            return "최종 안타수: \(scoreboard.hit)"
        case .empty:
            return ""
        }
    }
}

func output(_ type: OutputType) {
    print(type.description)
}

func output(types: [OutputType]) {
    print(types.map { $0.description }.joined(separator: " "))
}
