//
//  EvaluateMovesTests.swift
//  TicTacToe2
//
//  Created by Amy Roberson on 12/15/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest
@testable import TicTacToe2

class EvaluateMovesTests: XCTestCase {

    
func testEvaluateMove(){
        let x = Game()
        let players = setPlayerNames(input1: "Me", input2: "you")
        x.players.append(players[0])
        x.players.append(players[1])
        let result: Bool = x.evaluateandPlace(input: (x:1, y:1), currentPlayer: x.players[0])
        let expected: Bool = true
        XCTAssertEqual(expected, result)
    }
    
    func testEvaluateMove1(){
        let x = Game()
        let players = setPlayerNames(input1: "Me", input2: "you")
        x.players.append(players[0])
        x.players.append(players[1])
        _ = x.evaluateandPlace(input: (x:1, y:1), currentPlayer: x.players[0])
        let result: Bool = x.evaluateandPlace(input: (x:0, y:1), currentPlayer: x.players[0])
        let expected: Bool = false
        XCTAssertEqual(expected, result)
    }
    
    
    func testEvaluateMove2(){
        let x = Game()
        let players = setPlayerNames(input1: "Me", input2: "you")
        x.players.append(players[0])
        x.players.append(players[1])
        _ = x.evaluateandPlace(input: (x:1, y:1), currentPlayer: x.players[0])
        let result: Bool = x.evaluateandPlace(input: (x:1, y:1), currentPlayer: x.players[1])
        let expected: Bool = false
        XCTAssertEqual(expected, result)
    }
    
    
    

}
