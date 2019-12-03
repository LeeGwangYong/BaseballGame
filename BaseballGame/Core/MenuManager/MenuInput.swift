//
//  MenuInput.swift
//  BaseballGame
//
//  Created by 이광용 on 2019/12/04.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

enum MenuInputError: LocalizedError {

    case menuIsNotExsits

    var errorDescription: String? {
        switch self {
        case .menuIsNotExsits:
            return "존재하지 않는 메뉴입니다."
        }
    }

}

enum MenuInputLog: CustomStringConvertible {

    case select(sizeOfMenu: Int)

    var description: String {
        switch self {
        case .select(let sizeOfMenu):
            let firstIndex = 1
            return "메뉴 선택 (\(firstIndex) - \(sizeOfMenu)) "
        }
    }
    
}

private let menus = Menu.allCases
func inputMenu() throws -> Menu {
    print(MenuInputLog.select(sizeOfMenu: menus.count))
    guard let selectedMenu = readLine(),
        let index = Int(selectedMenu),
        let menu = menus[safe: index - 1] else {
        throw MenuInputError.menuIsNotExsits
    }
    return menu
}
