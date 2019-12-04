//
//  GameProcessor.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum ProcessLog: CustomStringConvertible {

    case attack(round: Int, order: AttackOrder, team: Team)
    case member(_ mebmer: Member)
    case hitterState(_ state: HitterState)
    case currentProgress(_ progress: GameProgress)

    var description: String {
        switch self {
        case .attack(let round, let order, let team):
            return "\(round)회\(order.description) \(team.name)의 공격" + .newLine
        case .member(let member):
            return "\(member.number)번 \(member.name)"
        case .hitterState(let state):
            return state.description
        case .currentProgress(let progress):
            return "\(progress.hitter.strike)S, \(progress.hitter.ball)B, \(progress.scoreBoard.out)O"
        }
    }

}

func process(about round: Int = 1,
             topTeam: Team, topProgress: GameProgress,
             bottomTeam: Team, bottomProgress: GameProgress) throws -> (GameProgress, GameProgress)  {
        let maximumRound = 6
        guard round <= maximumRound else {
            return (topProgress, bottomProgress)
        }
        let progresses = try AttackOrder.allCases.map { order -> GameProgress in
            let team = order == .top ? topTeam : bottomTeam
            let previousProgrss = order == .top ? topProgress : bottomProgress
            print(ProcessLog.attack(round: round, order: order, team: team))
            return try process(about: team, progress: GameProgress(score: previousProgrss.score,
                                                                   memberIndex: previousProgrss.memberIndex))
        }
        return try process(about: round + 1,
                           topTeam: topTeam, topProgress: progresses[0],
                           bottomTeam: bottomTeam, bottomProgress: progresses[1])
}

private func process(about team: Team, progress: GameProgress) throws -> GameProgress {
    guard !progress.isOvered else {
        return progress
    }
    let member =  team.members[progress.memberIndex]
    print(ProcessLog.member(member))
    return try process(about: team, progress: process(about: member, progress: progress))
}

private func process(about member: Member, progress: GameProgress) throws -> GameProgress {
    let state = try hitterState(of: member)
    switch state {
    case .hit:
        return process(hitterState: state, progress: progress)
    case .ball:
        let _progress = process(hitterState: state, progress: progress)
        return try process(about: member, progress: _progress)
    case .strike:
        guard progress.hitter.strike + 1 < maximumStrike else {
            print(ProcessLog.hitterState(.strike))
            return process(hitterState: .out, progress: progress)
        }
        let _progress = process(hitterState: state, progress: progress)
        return try process(about: member, progress: _progress)
    case .out:
        return process(hitterState: state, progress: progress)
    }
}

private func process(hitterState: HitterState, progress: GameProgress) -> GameProgress {
    print(ProcessLog.hitterState(hitterState))
    let _progress: GameProgress
    switch hitterState {
    case .hit:
        _progress = hitted(progress)
    case .ball:
        _progress = balled(progress)
    case .strike:
        _progress = striked(progress)
    case .out:
        _progress = outed(progress)
    }
    print(ProcessLog.currentProgress(_progress))
    print()
    return _progress
}

private func hitted(_ progress: GameProgress) -> GameProgress {
    let scoreBoard = ScoreBoard(hit: progress.scoreBoard.hit + 1,
                                out: progress.scoreBoard.out)
    return GameProgress(hitter: Hitter(),
                        scoreBoard: scoreBoard,
                        score: score(by: scoreBoard.hit),
                        memberIndex: progress.memberIndex + 1,
                        isOvered: progress.isOvered)
}

private func score(by hit: Int) -> Int {
    let _score = hit - 3
    return _score > 0 ? _score : 0
}

private let maximumBall = 4
private func balled(_ progress: GameProgress) -> GameProgress {
    let hitter = Hitter(strike: progress.hitter.strike,
                        ball: progress.hitter.ball + 1)
    return hitter.ball >= maximumBall ?
        process(hitterState: .hit, progress: progress) : GameProgress(hitter: hitter,
                                                                      scoreBoard: progress.scoreBoard,
                                                                      score: progress.score,
                                                                      memberIndex: progress.memberIndex,
                                                                      isOvered: progress.isOvered)
}

private let maximumStrike = 3
private let maximumOut = 3
private func striked(_ progress: GameProgress) -> GameProgress {
    let hitter = Hitter(strike: progress.hitter.strike + 1,
                        ball: progress.hitter.ball)
    return GameProgress(hitter: hitter,
                        scoreBoard: progress.scoreBoard,
                        score: progress.score,
                        memberIndex: progress.memberIndex,
                        isOvered: progress.isOvered)
}

private func outed(_ progress: GameProgress) -> GameProgress {
    let scoreBoard = ScoreBoard(hit: progress.scoreBoard.hit, out: progress.scoreBoard.out + 1)
    let isGameOvered = scoreBoard.out >= maximumOut
    return GameProgress(hitter: Hitter(),
                        scoreBoard: scoreBoard,
                        score: progress.score,
                        memberIndex: progress.memberIndex + 1,
                        isOvered: isGameOvered)
}
