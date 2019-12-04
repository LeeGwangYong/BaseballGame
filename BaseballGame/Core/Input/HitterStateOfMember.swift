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
    let strikeAverage = (1 - hitAverage) / 2 - 0.05
    let ballAverage = (1 - hitAverage) / 2 - 0.05
    let outAverage = 0.1
    let rawValue = [hitAverage, strikeAverage, ballAverage, outAverage].randomNumberWithGivenDistribution()
    guard let state = HitterState(rawValue: rawValue) else {
        throw HitterStateError.isNoMatchingHitterState
    }
    return state
}
