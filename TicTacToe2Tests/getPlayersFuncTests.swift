//
//  getPlayersFuncTests.swift
//  TicTacToe2
//
//  Created by Amy Roberson on 12/15/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest
@testable import TicTacToe2

class getPlayersFuncTests: XCTestCase {

    func testGetPlayerNames(){
        let playerName1 = "Me"//mock user input not testable
        let playerName2 = "You"// mock user input not testable
        let playerX = Player(name:playerName1, mark: .x)
        let playerO = Player(name:playerName2, mark: .o)
        XCTAssertEqual(playerX.name, playerName1)
        XCTAssertEqual(playerO.name, playerName2)
    }
    
    func testGetPlayerNames1(){
        let playerName1 = "1"//mock user input not testable
        let playerName2 = "2"// mock user input not testable
        let playerX = Player(name:playerName1, mark: .x)
        let playerO = Player(name:playerName2, mark: .o)
        XCTAssertEqual(playerX.name, playerName1)
        XCTAssertEqual(playerO.name, playerName2)
    }
    
    func testSettingPlayersNames(){
        let players = setPlayerNames(input1: "You", input2: "Me")
        let expected = 2
        let result = players.count
        XCTAssertEqual(expected, result)
    }
    
    func testSettingPlayersNames1(){
        let players = setPlayerNames(input1: "You", input2: "Me")
        let expected = "You"
        let result = players[0].name
        XCTAssertEqual(expected, result)
    }

}
