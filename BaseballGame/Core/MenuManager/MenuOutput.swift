//
//  MenuOutput.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/04.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum MenuOutputLog: CustomStringConvertible {

    case menu(_ menu: Menu)

    var description: String {
        switch self {
        case .menu(let menu):
            return "\(menu.rawValue). \(menu.description)"
        }
    }

}

func output(menus: [Menu]) {
    menus.forEach {
        print(MenuOutputLog.menu($0))
    }
    print()
}
