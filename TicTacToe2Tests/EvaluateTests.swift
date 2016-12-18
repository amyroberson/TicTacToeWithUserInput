//
//  EvaluateTests.swift
//  TicTacToe2
//
//  Created by Amy Roberson on 12/15/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest
@testable import TicTacToe2

class EvaluateTests: XCTestCase {

    func testEvaluateYN(){
        let result = evaluateYN(input: "y")
        let expected = true
        XCTAssertEqual(result, expected)
    }

    func testEvaluateYN1(){
        let result = evaluateYN(input: "Y")
        let expected = true
        XCTAssertEqual(result, expected)
    }
    
    func testEvaluateYN2(){
        let result = evaluateYN(input: "n")
        let expected = false
        XCTAssertEqual(result, expected)
    }
    
    func testEvaluateYN3(){
        let result = evaluateYN(input: "N")
        let expected = false
        XCTAssertEqual(result, expected)
    }
}
