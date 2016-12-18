//
//  MethodsTests.swift
//  TicTacToe2
//
//  Created by Amy Roberson on 12/16/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest
@testable import TicTacToe2

class MethodsTests: XCTestCase {

    func testSwitch(){
        let x: Marker = .x
        let expected = "X"
        let result = x.toString()
        XCTAssertEqual(expected, result)
    }
    
    func testSwitch1(){
        let x: Marker = .o
        let expected = "O"
        let result = x.toString()
        XCTAssertEqual(expected, result)
    }
   
    func testSwitch2(){
        let x: Marker = .empty
        let expected = " "
        let result = x.toString()
        XCTAssertEqual(expected, result)
    }
    
    func testGameBoardString(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2 )
        let result = x.description
        let expected = "   |   |  \n --------- \n   |   |   \n --------- \n   |   |  "
        XCTAssertEqual(expected, result)
    }

    func testGameBoardString1(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2 )
        x[0,1] = .x
        let result = x.description
        let expected = "   | X |  \n --------- \n   |   |   \n --------- \n   |   |  "
        XCTAssertEqual(expected, result)
    }
    
    func testGameBoardString2(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2 )
        x[0,1] = .x
        x[1,1] = .x
        x[2,1] = .o
        x[0,0] = .o
        let result = x.description
        let expected = " O | X |  \n --------- \n   | X |   \n --------- \n   | O |  "
        XCTAssertEqual(expected, result)
    }
    
    func testgetSpace(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2 )
        let result = x.getSpace(x: 2, y: 2, currentPlayer: x.player2)
        let expected = (2,2)
        XCTAssertEqual(expected.0, result.0)
        XCTAssertEqual(expected.1, result.1)
    }
    
    func testgetSpace1(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2 )
        let result = x.getSpace(x: 0, y: 0, currentPlayer: x.player2)
        let expected = (0,0)
        XCTAssertEqual(expected.0, result.0)
        XCTAssertEqual(expected.1, result.1)
    }
    
    func testgetSpace2(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2 )
        let result = x.getSpace(x: 1, y: 0, currentPlayer: x.player2)
        let expected = (1,0)
        XCTAssertEqual(expected.0, result.0)
        XCTAssertEqual(expected.1, result.1)
    }
    
    func testgetSpace3(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2 )
        let result = x.getSpace(x: 1, y: 1, currentPlayer: x.player2)
        let expected = (1,1)
        XCTAssertEqual(expected.0, result.0)
        XCTAssertEqual(expected.1, result.1)
    }
    
    func testgetSpace4(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2 )
        let result = x.getSpace(x: 2, y: 0, currentPlayer: x.player2)
        let expected = (2,0)
        XCTAssertEqual(expected.0, result.0)
        XCTAssertEqual(expected.1, result.1)
    }
    
    func testThereIsAWinner(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .x
        x[0,1] = .x
        x[0,2] = .x
        let result = x.thereIsAWinner()
        let expected: Marker = .x
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner1(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .o
        x[0,1] = .o
        x[0,2] = .o
        let result = x.thereIsAWinner()
        let expected: Marker = .o
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner2(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[1,0] = .o
        x[1,1] = .o
        x[1,2] = .o
        let result = x.thereIsAWinner()
        let expected: Marker = .o
        XCTAssertEqual(result, expected)
    }
    func testThereIsAWinner3(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[2,0] = .x
        x[2,1] = .x
        x[2,2] = .x
        let result = x.thereIsAWinner()
        let expected: Marker = .x
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner4(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[2,0] = .o
        x[2,1] = .o
        x[2,2] = .o
        let result = x.thereIsAWinner()
        let expected: Marker = .o
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner5(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .o
        x[1,1] = .o
        x[2,2] = .o
        let result = x.thereIsAWinner()
        let expected: Marker = .o
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner6(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .x
        x[1,1] = .x
        x[2,2] = .x
        let result = x.thereIsAWinner()
        let expected: Marker = .x
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner7(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .x
        x[1,0] = .x
        x[2,0] = .x
        let result = x.thereIsAWinner()
        let expected: Marker = .x
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner8(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .o
        x[1,0] = .o
        x[2,0] = .o
        let result = x.thereIsAWinner()
        let expected: Marker = .o
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner9(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,1] = .o
        x[1,1] = .o
        x[2,1] = .o
        let result = x.thereIsAWinner()
        let expected: Marker = .o
        XCTAssertEqual(result, expected)
    }

    func testThereIsAWinner10(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,1] = .x
        x[1,1] = .x
        x[2,1] = .x
        let result = x.thereIsAWinner()
        let expected: Marker = .x
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner11(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[1,0] = .x
        x[1,1] = .x
        x[1,2] = .x
        let result = x.thereIsAWinner()
        let expected: Marker = .x
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner12(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,2] = .x
        x[1,2] = .x
        x[2,2] = .x
        let result = x.thereIsAWinner()
        let expected: Marker = .x
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner13(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,2] = .o
        x[1,2] = .o
        x[2,2] = .o
        let result = x.thereIsAWinner()
        let expected: Marker = .o
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner14(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,2] = .o
        x[1,1] = .o
        x[2,0] = .o
        let result = x.thereIsAWinner()
        let expected: Marker = .o
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner15(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,2] = .x
        x[1,1] = .x
        x[2,0] = .x
        let result = x.thereIsAWinner()
        let expected: Marker = .x
        XCTAssertEqual(result, expected)
    }
    
    func testThereIsAWinner16(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,2] = .x
        x[1,1] = .o
        x[2,0] = .x
        let result = x.thereIsAWinner()
        let expected: Marker = .empty
        XCTAssertEqual(result, expected)
    }
    
    func testIsBoardFull(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        let result = x.isBoardFull()
        XCTAssertFalse(result)
    }
    
    func testIsBoardFull1(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .x
        x[1,1] = .o
        x[2,2] = .x
        x[0,1] = .x
        x[0,2] = .o
        x[1,0] = .o
        x[1,2] = .x
        x[2,0] = .o
        x[2,1] = .x
        XCTAssertTrue(x.isBoardFull())
    }
    
    func testIsGameOver(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .x
        x[1,1] = .o
        x[2,2] = .x
        x[0,1] = .x
        x[0,2] = .o
        x[1,0] = .o
        x[1,2] = .x
        x[2,0] = .o
        x[2,1] = .x
        let expected = true
        let result = x.isGameOver()
        XCTAssertEqual(expected, result)
    }
    
    func testIsGameOver1(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .x
        x[1,1] = .o
        x[2,2] = .x
        x[0,1] = .o
        x[0,2] = .x
        x[1,0] = .x
        x[1,2] = .o
        x[2,0] = .o
        x[2,1] = .x
        let expected = true
        let result = x.isGameOver()
        XCTAssertEqual(expected, result)
    }
    
    func testIsGameOver2(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .x
        x[1,0] = .x
        x[1,2] = .o
        x[2,0] = .o
        x[2,1] = .x
        let expected = false
        let result = x.isGameOver()
        XCTAssertEqual(expected, result)
    }
    
    func testIsGameOver3(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let x = Game(player1:p1 ,player2:p2)
        x[0,0] = .x
        x[1,0] = .x
        x[1,2] = .o
        x[2,0] = .x
        x[2,1] = .x
        let expected = true
        let result = x.isGameOver()
        XCTAssertEqual(expected, result)
    }
    
    func testGet(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let game = Game(player1: p1, player2: p2)
        XCTAssertThrowsError(try game.get(row: 3, column: 4))
    }
    
    func testGet1(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let game = Game(player1: p1, player2: p2)
        XCTAssertThrowsError(try game.get(row: -3, column: -4))
    }
    
    func testGet2(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let game = Game(player1: p1, player2: p2)
        XCTAssertThrowsError(try game.get(row: -3, column: 1))
    }
    
    func testAdd(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let game = Game(player1: p1, player2: p2)
        XCTAssertThrowsError(try game.add(marker: .x, at: (row:3, column: 4)))
    }

    func testAdd2(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let game = Game(player1: p1, player2: p2)
        XCTAssertThrowsError(try game.add(marker: .x, at: (row:-3, column: -4)))
    }
    
    func testAdd3(){
        let p1 = Player(name: "me", mark: .x)
        let p2 = Player(name: "you", mark: .o)
        let game = Game(player1: p1, player2: p2)
        let expected = Game(lastPlayed: .x, grid: [.empty, .empty, .empty, .empty, .x, .empty, .empty, .empty, .empty], player1: p1, player2: p2, gameOutCome: nil)
        do{
            try game.add(marker: .x, at: (row:1, column: 1))
        } catch {
            XCTAssert(false)
        }
        XCTAssert(game == expected)
    }
}
