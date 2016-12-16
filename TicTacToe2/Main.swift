//
//  Main.swift
//  TicTacToe2
//
//  Created by Amy Roberson on 12/15/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import Foundation

func mainLoop() {
    //print("Hello, what is your name?")
    //print(readLine(strippingNewline: true)!)
    
    //let myString = "Amy Roberson"
    //creates a txt file that holds myString that can be edited outside of xcode
    //try? myString.write(toFile: "/User/amy/Desktop/Foo.txt", atomically: true, encoding: .utf8)

    //once you have a file
    //let myString = try!....
}
enum GridGetError: Error {
    case notOnTheGrid
}

enum Marker{
    case x
    case o
    case empty
    
    func toString()-> String {
        switch self{
        case .x:
            return "X"
        case .o:
            return "O"
        case .empty:
            return " "
        }
    }
}

struct Player {
    let marker: Marker //John.marker for grid space
    let name: String
    var numberOfWins : Int
    var numberOfLosses: Int
    
    init(name: String, mark: Marker){
        self.name = name
        self.marker = mark
        numberOfWins = 0
        numberOfLosses = 0
    }
}

class Game : CustomStringConvertible {
    var lastPlayed: Marker = .empty
    let rows = 3, columns = 3
    var grid: [Marker]
    var player1: Player
    var player2: Player
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        self.grid = Array(repeating: .empty, count: rows * columns)
    }
    var description: String
        {return " \(self[0,0].toString()) | \(self[0,1].toString()) | \(self[0,2].toString())\n --------- \n \(self[1,0].toString()) | \(self[1,1].toString()) | \(self[1,2].toString()) \n --------- \n \(self[2,0].toString()) | \(self[2,1].toString()) | \(self[2,2].toString())"
        }
    
    subscript(row: Int, column: Int) -> Marker {
        get {
            if (row < rows && row > -1) &&
                (column < columns && column > -1) {
                return grid[(row * columns) + column]
            } else {
                fatalError("Invalid InPut")// throw an error here?
            }
        }
        
        set {
            grid[(row * columns) + column] = newValue
        }
    }
    
    func boardSpaceAvailable(x: Int, y: Int) -> Bool {//might should delete
        if self[x,y] != .empty{
            return false
        } else {return true}
    }
    
    func evaluateandPlace(input: (x: Int, y: Int), currentPlayer: Player)-> Bool {
             if currentPlayer.marker == lastPlayed {
                return false //possibly throw an error later
             } else if self[input.x, input.y] != .empty {
                return false
             } else {
                self[input.x, input.y] = currentPlayer.marker
                self.lastPlayed = currentPlayer.marker
                return true
            }
    }
    
    func getSpace(x: Int, y: Int, currentPlayer: Player) -> (Int, Int){
        print("\(currentPlayer.name), It is your turn, pick a space!")
        
        print(self.description)
        return (x,y)
    }
    
}

func getIntFromTheUser(prompt: String) -> Int{
    print(prompt)
    var number: Int?
    while number == nil{
        if let x = readLine(strippingNewline: true),
            let tempNumber = Int(x) {
            number = tempNumber
        } else {
            print("That was an invalid number")
        }
    }
    return number!
}

func getStringFromTheUser(prompt: String) -> String {
    print(prompt)
    var newString: String?
    while newString == nil{
        if let tempString = readLine(strippingNewline: true){
            newString = tempString
        } else {
            print("That wasn't a valid answer,\(prompt)")
        }
    }
    return newString!
}

//readline Get names, initialize players
func setPlayerNames(input1: String, input2: String) -> [Player]{
    let firstPlayer = Player(name: input1, mark: .x)
    let secondPlayer = Player(name: input2, mark: .o)
    let players = [firstPlayer, secondPlayer]
    return players
}

//player  what is your move
func getRowSpaceFromUser(currentRound: Game) -> Int{
    let prompt = "Please enter a number between 1 and 3 for the row"
    var x = getIntFromTheUser(prompt: prompt)
    if x > 3 || x < 1{
        x = getIntFromTheUser(prompt: prompt)
    }
    return x
}

func getColumnSpaceFromUser(currentRound: Game) -> Int{
    let prompt = "Please enter a number between 1 and 3 for the column"
    var y = getIntFromTheUser(prompt: prompt)
    if y > 3 || y < 1{
        y = getIntFromTheUser(prompt: prompt)
    }
    return y
}

/*func getSpaceFromUser(currentRound: Game, player: Player) -> (Int,Int){ //might work better as a method
    print("\(player.name), It is your turn, pick a space!")
    print(currentRound.description)
    let x = getRowSpaceFromUser(currentRound: currentRound)
    let y = getColumnSpaceFromUser(currentRound: currentRound)
    return(x,y)
}*/

    
/*func toPlayGame() -> Game {
    let first = getStringFromTheUser(prompt: "What is player one's name?")
    let second = getStringFromTheUser(prompt: "What is player two's name?")
    var players = setPlayerNames(input1: first, input2: second)
    //var currentRound = Game()
   // currentRound.players.append(players[0])
    //currentRound.players.append(players[1])
    
    
    
    
    //while no winner and board is not full
    //player goes getSpace
    //validate Space and check for winner and update last player
    
    
   // return currentRound
}

func startTicTacToe(){
    print("Welcome to TicTacToe!")
    //let gameArray: [Game] = []
    
    //add games to array and check to see if match is over
    //if match is over print out game stats
}
*/

//readline get moves, evaluate space, evaluate win







