//
//  Team.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/03.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

struct Team {

    let name: String
    let members: [Member]

    static func sampleTeamsForTest() -> [Team] {
        return [Team(name: "Top Team", members: [Member(number: 1, name: "가", hitAverage: 0.123),
                                 Member(number: 2, name: "나", hitAverage: 0.324),
                                 Member(number: 3, name: "다", hitAverage: 0.492),
                                 Member(number: 4, name: "라", hitAverage: 0.238),
                                 Member(number: 5, name: "마", hitAverage: 0.452),
                                 Member(number: 6, name: "바", hitAverage: 0.434),
                                 Member(number: 7, name: "사", hitAverage: 0.392),
                                 Member(number: 8, name: "아", hitAverage: 0.334),
                                 Member(number: 9, name: "자", hitAverage: 0.284)]),
                Team(name: "Bottom Team", members: [Member(number: 1, name: "A", hitAverage: 0.123),
                                                    Member(number: 2, name: "B", hitAverage: 0.324),
                                                    Member(number: 3, name: "C", hitAverage: 0.492),
                                                    Member(number: 4, name: "D", hitAverage: 0.238),
                                                    Member(number: 5, name: "E", hitAverage: 0.452),
                                                    Member(number: 6, name: "F", hitAverage: 0.434),
                                                    Member(number: 7, name: "G", hitAverage: 0.392),
                                                    Member(number: 8, name: "H", hitAverage: 0.334),
                                                    Member(number: 9, name: "I", hitAverage: 0.284)])]
    }

}
