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
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
    do{
        let result: Bool = try x.evaluateandPlace(input: (x:1, y:1), currentPlayer: x.player1)
        let expected = true
        XCTAssertEqual(result, expected)
    } catch {
        XCTAssert(false, "Caught \(error)")
        
    }
    }
    
    func testEvaluateMove2(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(lastPlayed: .x, grid: [.x,.empty,.empty,.x,.empty,.empty,.o,.empty,.empty], player1: p1, player2: p2, gameOutCome: nil)
        XCTAssertThrowsError(try x.evaluateandPlace(input: (x:0, y:0), currentPlayer: x.player1))
        
    }
  
    func testEvaluateMove3(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(lastPlayed: .o, grid: [.x,.empty,.empty,.x,.empty,.empty,.o,.empty,.empty], player1: p1, player2: p2, gameOutCome: nil)
        XCTAssertThrowsError(try x.evaluateandPlace(input: (x:0, y:0), currentPlayer: x.player1))
        
    }
}
