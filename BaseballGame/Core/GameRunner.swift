//
//  GameRunner.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/04.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum GameRunnerLog: CustomStringConvertible {

    case opening
    case menus(_ menus: [Menu])
    case versus(_ topTeam: Team, _ bottomTeam: Team)
    case start(_ topTeam: Team, _ bottomTeam: Team)
    case finalScore(_ topProgress: GameProgress, _ bottomProgress: GameProgress)
    case end
    case closing


    var description: String {
        switch self {
        case .opening:
            return "신나는 야구시합"
        case .menus(let menus):
            return menus.map { MenuOutputLog.menu($0).description }.joined(separator: .newLine) + .newLine
        case .versus(let topTeam, let bottomTeam):
            return "\(topTeam.name) VS \(bottomTeam.name)"
        case .start(let topTeam, let bottomTeam):
            return GameRunnerLog.versus(topTeam, bottomTeam).description + "의 시합을 시작합니다." + .newLine
        case .finalScore(let topProgress, let bottomProgress):
            return "\(topProgress.score) : \(bottomProgress.score)"
        case .end:
            return "경기 종료"
        case .closing:
            return "Thank you!"
        }
    }

}

func gameStart() throws {
    var mutableTeams = [Team]() 

    while(true) {
        print(GameRunnerLog.opening)
        print(GameRunnerLog.menus(Menu.allCases))
        let menu = try inputMenu()
        switch menu {
        case .inputData:
            mutableTeams = try inputTeams()
        case .outputData:
            try output(teams: mutableTeams)
        case .run:
            try run(teams: mutableTeams)
            return
        }
    }
}

private func run(teams: [Team]) throws {
    guard let topTeam = teams[safe: 0],
        let bottomTeam = teams[safe: 1] else {
            throw TeamOutputError.teamIsWrongOrNotExsist
    }
    print(GameRunnerLog.start(topTeam, bottomTeam))
    let result = try process(topTeam: topTeam, topProgress: GameProgress(memberIndex: 0),
                             bottomTeam: bottomTeam, bottomProgress: GameProgress(memberIndex: 0))
    log(topTeam: topTeam, topProgress: result.0,
        bottomTeam: bottomTeam, bottomProgress: result.1)
}

private func log(topTeam: Team, topProgress: GameProgress,
                 bottomTeam: Team, bottomProgress: GameProgress) {
    print(GameRunnerLog.end)
    print()
    print(GameRunnerLog.versus(topTeam, bottomTeam))
    print(GameRunnerLog.finalScore(topProgress, bottomProgress))
    print(GameRunnerLog.closing)
}
