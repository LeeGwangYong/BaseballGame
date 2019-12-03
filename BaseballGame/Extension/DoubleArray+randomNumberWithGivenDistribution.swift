//
//  DoubleArray+randomNumberWithGivenDistribution.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/04.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

// https://codeday.me/ko/qa/20190423/389139.html

extension Array where Element == Double {

    func randomNumberWithGivenDistribution() -> Int {
        let sum = self.reduce(0, +)
        let random = Double.random(in: 0.0 ..< sum)
        var accumulated = 0.0
        for (i, p) in self.enumerated() {
            accumulated += p
            if random < accumulated {
                return i
            }
        }
        return self.count - 1
    }

}
