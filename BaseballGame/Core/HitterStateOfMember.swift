//
//  HitterStateForMember.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/04.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum HitterStateError: LocalizedError {

    case isNoMatchingHitterState

    var errorDescription: String? {
        switch self {
        case .isNoMatchingHitterState:
            return "알맞는 HitterState가 존재하지 않습니다."
        }
    }

}

func hitterState(of member: Member) throws -> HitterState {
    let rawValueOfHitterState = averages(of: member).randomNumberWithGivenDistribution()
    guard let state = HitterState(rawValue: rawValueOfHitterState) else {
        throw HitterStateError.isNoMatchingHitterState
    }
    return state
}

private func averages(of member: Member) -> [Double] {
    let hitAverage = member.hitAverage
    let outAverage = 0.1
    return [hitAverage, strikeAverage(from: hitAverage), ballAverage(from: hitAverage), outAverage]
}

private func strikeAverage(from hitAverage: Double) -> Double {
    return (1 - hitAverage) / 2 - 0.05
}

private func ballAverage(from hitAverage: Double) -> Double  {
    return (1 - hitAverage) / 2 - 0.05
}
