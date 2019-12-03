//
//  TeamOutput.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum TeamOutputError: LocalizedError {

    case teamIsWrongOrNotExsist

    var errorDescription: String? {
        switch self {
        case.teamIsWrongOrNotExsist:
            return "팀이 잘못되었거나 존재하지 않습니다."
        }
    }

}

enum TeamOutputLog: CustomStringConvertible {

    case teamInfo(_ team: Team)
    case memberInfo(_ member: Member)

    var description: String {
        switch self {
        case .teamInfo(let team):
            return "\(team.name) 팀 정보"
        case .memberInfo(let member):
            return "\(member.number)번 \(member.name), \(member.hitAverage)"
        }
    }
    
}

func output(teams: [Team]) throws {
    guard teams.count == 2 else {
        throw TeamOutputError.teamIsWrongOrNotExsist
    }
    teams.forEach {
        print(TeamOutputLog.teamInfo($0))
        $0.members.forEach {
            print(TeamOutputLog.memberInfo($0))
        }
    }
    print()
}
