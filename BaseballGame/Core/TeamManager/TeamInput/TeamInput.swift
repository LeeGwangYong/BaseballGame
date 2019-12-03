//
//  TeamInput.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum TeamInputError: LocalizedError {
    
    case teamNameIsMissing
    case memberInfoIsMissing
    case invalidMemberInfo
    case hitAverageIsOutOfRange
    
    var errorDescription: String? {
        switch self {
        case .teamNameIsMissing:
            return "팀명이 존재하지 않습니다."
        case .memberInfoIsMissing:
            return "타자 정보가 존재하지 않습니다."
        case .invalidMemberInfo:
            return "타자 정보가 유효하지 않습니다."
        case .hitAverageIsOutOfRange:
            return "타율이 범위를 벗어났습니다."
        }
    }
    
}

private let minimumHitAverage = 0.1
private let maximumHitAverage = 0.5

enum TeamInputLog: CustomStringConvertible {

    case teamName(index: Int)
    case memberInfo(index: Int)
    case complete

    var description: String {
        switch self {
        case .teamName(let index):
            return "\(index)팀의 이름을 입력하세요> "
        case .memberInfo(let index):
            return "\(index)번 타자 정보 입력> "
        case .complete:
            return "팀 데이터 입력이 완료되었습니다."
        }
    }

}

func inputTeams() throws -> [Team] {
    let teams = try (1...2).map { index -> Team in
        print(TeamInputLog.teamName(index: index))
        return try team()
    }
    print(TeamInputLog.complete)
    print()
    return teams
}

private func team() throws -> Team {
    guard let teamName = readLine(),
        !teamName.isEmpty else {
            throw TeamInputError.teamNameIsMissing
    }
    return Team(name: teamName, members: try members())
}

private func members() throws -> [Member] {
    let _members = try (1...9).map { index -> Member in
        print(TeamInputLog.memberInfo(index: index))
        guard let info = readLine(),
            !info.isEmpty else {
                throw TeamInputError.memberInfoIsMissing
        }
        return try member(index: index,
                          from: info.components(separatedBy: ", "))
    }
    print()
    return _members
}

private func member(index: Int, from infoComponents: [String]) throws -> Member {
    guard let name = infoComponents[safe: 0],
        let hitAverageStr = infoComponents[safe: 1],
        let hitAverage = Double(hitAverageStr) else {
            throw TeamInputError.invalidMemberInfo
    }
    guard minimumHitAverage < hitAverage && hitAverage < maximumHitAverage else {
        throw TeamInputError.hitAverageIsOutOfRange
    }
    return Member(number: index, name: name, hitAverage: hitAverage)
}
