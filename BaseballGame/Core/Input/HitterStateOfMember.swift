//
//  HitterStateForMember.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/04.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

func hitterState(of member: Member) throws -> HitterState {
    let hitAverage = member.hitAverage
    let outAverage = 0.1
    let averages = [hitAverage, strikeAverage(from: hitAverage), ballAverage(from: hitAverage), outAverage]
    let rawValueOfHitterState = averages.randomNumberWithGivenDistribution()
    guard let state = HitterState(rawValue: rawValueOfHitterState) else {
        throw HitterStateError.isNoMatchingHitterState
    }
    return state
}

private func strikeAverage(from hitAverage: Double) -> Double {
    return (1 - hitAverage) / 2 - 0.05
}

private func ballAverage(from hitAverage: Double) -> Double  {
    return (1 - hitAverage) / 2 - 0.05
}
