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
        let x = Game()
        let result = x.description
        let expected = "   |   |  \n --------- \n   |   |   \n --------- \n   |   |  "
        XCTAssertEqual(expected, result)
    }

    func testGameBoardString1(){
        let x = Game()
        x[0,1] = .x
        let result = x.description
        let expected = "   | X |  \n --------- \n   |   |   \n --------- \n   |   |  "
        XCTAssertEqual(expected, result)
    }
    
    func testGameBoardString2(){
        let x = Game()
        x[0,1] = .x
        x[1,1] = .x
        x[2,1] = .o
        x[0,0] = .o
        let result = x.description
        let expected = " O | X |  \n --------- \n   | X |   \n --------- \n   | O |  "
        XCTAssertEqual(expected, result)
    }
    
}
