//
//  Main.swift
//  TicTacToe2
//
//  Created by Amy Roberson on 12/15/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import Foundation

enum TurnError: Error {
    case outOfTurn
    case spaceNotAvailable
}

enum BoardError: Error {
    case notOnBoard
}

enum FileError: Error{
    case noSupportDirectory
}
enum Marker{
    case x
    case o
    case empty
    
    func toString() -> String {
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

enum GameOutcome: CustomStringConvertible {
    case player1Wins
    case player2Wins
    case draw
    
    var description: String {
        switch self{
        case .player1Wins:
            return "player1Wins"
        case .player2Wins:
            return "player2Wins"
        case .draw:
            return "draw"
        }
    }
}

class Player: NSObject, NSCoding {
    let marker: Marker
    let name: String
    var numberOfWins : Int
    var numberOfLosses: Int
    
    convenience init(name: String, mark: Marker){
        self.init(name:name, mark:mark, numberOfWins: 0, numberOfLosses: 0)
    }
    
    init(name: String, mark: Marker, numberOfWins: Int, numberOfLosses: Int){
        self.name = name
        self.marker = mark
        self.numberOfWins = numberOfWins
        self.numberOfLosses = numberOfLosses
    }
    
    //MARK: NSCoding
    required convenience init?(coder decoder: NSCoder) {
        var marker: Marker
        let tmp = decoder.decodeObject(forKey: "marker") as? String
        if tmp == "x" {
            marker = Marker.x
        }else if tmp == "o" {
            marker = Marker.o
        } else {
            marker = Marker.empty //this needs to be tested by having a file read a player with marker .empty
        }
        guard let name = decoder.decodeObject(forKey: "name") as? String
            else {return nil}
        self.init(
            name: name,
            mark: marker,
            numberOfWins: decoder.decodeInteger(forKey: "numberOfWins"),
            numberOfLosses: decoder.decodeInteger(forKey: "numberOfLosses")
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        var tmp: String
        if self.marker == .x {
            tmp = "x"
        } else if self.marker == .o{
            tmp = "o"
        } else {
            tmp = "empty"
        }
        coder.encode(tmp, forKey: "marker")
        coder.encode(self.numberOfWins, forKey: "numberOfWins")
        coder.encode(self.numberOfLosses, forKey: "numberOfLosses")
    }
    
    static func ==(_ lhs: Player, _ rhs: Player) -> Bool{
        return lhs.name == rhs.name && lhs.marker == rhs.marker
        
    }
}

class Game: NSObject, NSCoding {
    var lastPlayed: Marker
    let rows: Int
    let columns: Int
    var grid: [Marker]
    var player1: Player
    var player2: Player
    var gameOutCome: GameOutcome?
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        self.rows = 3
        self.columns = 3
        self.grid = Array(repeating: .empty, count: rows * columns)
        self.lastPlayed = Marker.empty
    }
    
    init(lastPlayed:Marker, grid: [Marker], player1: Player, player2: Player, gameOutCome: GameOutcome?){
        self.lastPlayed = lastPlayed
        self.rows = 3
        self.columns = 3
        self.grid = grid
        self.player1 = player1
        self.player2 = player2
        self.gameOutCome = gameOutCome
    }
    
    //MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        var lastPlayed: Marker
        let tmp = decoder.decodeObject(forKey: "lastPlayed") as? String
        if tmp == "x" {
            lastPlayed = Marker.x
        }else if tmp == "o" {
            lastPlayed = Marker.o
        } else {
            lastPlayed = Marker.empty
        }
       
        var grid: [Marker] = []
        if let tmpGrid = decoder.decodeObject(forKey: "grid") as? [String] {
            for tmp in tmpGrid{
                if tmp == Marker.x.toString() {
                    grid.append(Marker.x)
                }else if tmp == Marker.o.toString() {
                    grid.append(Marker.o)
                } else {
                    grid.append(Marker.empty)
                }
            }
        } else {
            return nil
        }
        guard let player1 = decoder.decodeObject(forKey: "player1") as? Player,
              let player2 = decoder.decodeObject(forKey: "player2") as? Player else {
            return nil
        }
        var gameOutCome: GameOutcome?
        let tmpOutCome = decoder.decodeObject(forKey: "gameOutCome") as? String
        if tmpOutCome == GameOutcome.player1Wins.description{
            gameOutCome = GameOutcome.player1Wins
        } else if tmpOutCome == GameOutcome.player2Wins.description{
            gameOutCome = GameOutcome.player2Wins
        } else if tmpOutCome == "nil" || tmpOutCome == nil {
            gameOutCome = nil
        } else {
            gameOutCome = GameOutcome.draw
        }
        
        self.init(
            lastPlayed: lastPlayed,
            grid: grid,
            player1: player1,
            player2: player2,
            gameOutCome: gameOutCome
        )
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.lastPlayed.toString(), forKey: "lastPlayed")
        coder.encode(self.rows, forKey: "rows")
        coder.encode(self.columns, forKey: "column")
        coder.encode(self.grid.map{$0.toString()}, forKey: "grid")
        coder.encode(self.player1, forKey: "player1")
        coder.encode(self.player2, forKey: "player2")
        coder.encode(self.gameOutCome?.description, forKey: "gameOutCome")
    }
    
    
    
    override var description: String
    {
        return " \(self[0,0].toString()) | \(self[0,1].toString()) | \(self[0,2].toString())\n --------- \n \(self[1,0].toString()) | \(self[1,1].toString()) | \(self[1,2].toString()) \n --------- \n \(self[2,0].toString()) | \(self[2,1].toString()) | \(self[2,2].toString())"
    }
    
    subscript(row: Int, column: Int) -> Marker {
        get {
            do{
                return try self.get(row: row, column: column)
            }catch {
                fatalError() // can not throw from subscript
            }
        }
        
        set {
            do{
                try self.add(marker: newValue, at: (row: row, column: column))
            }catch {
                fatalError()  // can not throw from subscript
            }
        }
    }
    func get(row: Int, column:Int) throws -> Marker {
        if (row < rows && row > -1) &&
            (column < columns && column > -1) {
            return grid[(row * columns) + column]
        } else {
            print("That space was not on the board!")
            throw BoardError.notOnBoard
        }
    }
    
    func add(marker: Marker, at: (row: Int, column: Int)) throws {
        if (at.row < rows && at.row > -1) &&
            (at.column < columns && at.column > -1) {
                grid[(at.row * columns) + at.column] = marker
        } else {
            print("That space was not on the board!")
            throw BoardError.notOnBoard
        }
    }
    
    func evaluateandPlace(input: (x: Int, y: Int), currentPlayer: Player) throws -> Bool {
        if currentPlayer.marker == self.lastPlayed {
            throw TurnError.outOfTurn
        } else if self[input.x, input.y] != .empty {
            throw TurnError.spaceNotAvailable
        } else {
            self[input.x, input.y] = currentPlayer.marker
            self.lastPlayed = currentPlayer.marker
            return true
        }
    }
    
    func getCoordinatesFromUser(currentPlayer: Player) -> Bool {
        print("\(currentPlayer.name), It is your turn, pick a space!")
        print(self.description)
        do{
            let askUserForSpace = self.getSpace(x: getIntFromTheUser(prompt: "\(currentPlayer.name) Please enter a number 0, 1, or 2 for the row"), y: getIntFromTheUser(prompt: "\(currentPlayer.name) Please enter a number 0, 1, or 2 for the column"), currentPlayer: currentPlayer)
            let validMove = try self.evaluateandPlace(input: askUserForSpace, currentPlayer: currentPlayer)
            return validMove
        } catch TurnError.outOfTurn {
            print("It is not your turn!")
        } catch TurnError.spaceNotAvailable {
            print("That space is taken!")
        } catch {
            print("There was an error")
        }
        return false
    }
    
    func getSpace(x: Int, y: Int, currentPlayer: Player) -> (Int, Int){
        return (x,y)
    }
    
    static func ==(_ lhs: Game, _ rhs: Game) -> Bool{
        return lhs.grid == rhs.grid &&
            lhs.player1 == rhs.player1 &&
            lhs.player2 == rhs.player2 &&
            lhs.gameOutCome == rhs.gameOutCome
    }
    
    func thereIsAWinner() ->  Marker {
        if (self[0,0] == .x) && (self[0,1] == .x) && (self[0,2] == .x){
            return .x
        } else if (self[0,0] == .o) && (self[0,1] == .o) && (self[0,2] == .o){
            return .o
        } else if (self[1,0] == .x) && (self[1,1] == .x) && (self[1,2] == .x){
            return .x
        } else if (self[1,0] == .o) && (self[1,1] == .o) && (self[1,2] == .o){
            return .o
        } else if (self[2,0] == .x) && (self[2,1] == .x) && (self[2,2] == .x){
            return .x
        } else if (self[2,0] == .o) && (self[2,1] == .o) && (self[2,2] == .o){
            return .o
        } else if (self[0,0] == .x) && (self[1,1] == .x) && (self[2,2] == .x){
            return .x
        } else if (self[0,0] == .o) && (self[1,1] == .o) && (self[2,2] == .o){
            return .o
        } else if (self[0,0] == .x) && (self[1,0] == .x) && (self[2,0] == .x){
            return .x
        } else if (self[0,0] == .o) && (self[1,0] == .o) && (self[2,0] == .o){
            return .o
        } else if (self[0,1] == .x) && (self[1,1] == .x) && (self[2,1] == .x){
            return .x
        } else if (self[0,1] == .o) && (self[1,1] == .o) && (self[2,1] == .o){
            return .o
        } else if (self[0,2] == .x) && (self[1,2] == .x) && (self[2,2] == .x){
            return .x
        } else if (self[0,2] == .o) && (self[1,2] == .o) && (self[2,2] == .o){
            return .o
        } else if (self[0,2] == .x) && (self[1,1] == .x) && (self[2,0] == .x){
            return .x
        } else if (self[0,2] == .o) && (self[1,1] == .o) && (self[2,0] == .o){
            return .o
        } else {
            return .empty
        }
    }
    
    func isBoardFull() -> Bool {
        for i in self.grid{
            if i == .empty{
                return false
            }
        }
        return true
    }
    
    func isGameOver() -> Bool{
        if self.thereIsAWinner() != .empty {
            if self.thereIsAWinner() == .x {
                self.gameOutCome = .player1Wins
            }else if self.thereIsAWinner() == .o {
                self.gameOutCome = .player2Wins
            } else {
                self.gameOutCome = .draw
            }
            return true
        }
        if self.isBoardFull() {
            self.gameOutCome = .draw
            return true
        }
        return false
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

func evaluateYN(input: String) -> Bool {
    var userInput = input
    userInput = userInput.lowercased()
    var y: Bool
    if userInput == "y" {
        y = true
    } else {
        y = false
    }
    return y
}

func getHistoryFilePath() throws -> URL{
    guard let supportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
        throw FileError.noSupportDirectory
    }
    var supportFile = supportDir.appendingPathComponent("TicTacToe")
    try FileManager.default.createDirectory(at: supportFile, withIntermediateDirectories: true, attributes: nil)
    supportFile = supportFile.appendingPathComponent("history.plist")
    return supportFile
}

func gamePlay(players:(Player, Player)) -> Game {
    let first = players.0
    let second = players.1
    let currentRound = Game(player1: first, player2: second)
    var isOver = false
    while !isOver{
        var validMovePlayer1 = false
        while !validMovePlayer1 { //test for board validation
            validMovePlayer1 = currentRound.getCoordinatesFromUser(currentPlayer: first)
        }
        isOver = currentRound.isGameOver()
        if isOver{
            continue
        }
        var validMovePlayer2 = false
        while !validMovePlayer2 {//test for board validation
            validMovePlayer2 = currentRound.getCoordinatesFromUser(currentPlayer: second)
        }
        isOver = currentRound.isGameOver()
    }
    switch currentRound.thereIsAWinner() {
    case .x:
        print("\(players.0.name) wins!")
        players.0.numberOfWins += 1
        players.1.numberOfLosses += 1
    case .o:
        print("\(players.1.name) wins!")
        players.0.numberOfWins += 1
        players.1.numberOfLosses += 1
    case .empty:
        print("\(players.0.name) vs \(players.1.name) ends in a draw!")
    }
    return currentRound
}

func loadSavedGames() -> [Game] {
    var gameArray: [Game] = []
    do {
        let file = try getHistoryFilePath()
        if FileManager.default.fileExists(atPath: file.path) {
            if let tmp = NSKeyedUnarchiver.unarchiveObject(withFile: file.path) as? [Game] {
                gameArray = tmp
            }
        }
    } catch{
        print("failed to load history")
        print("\(error)")
    }
    return gameArray
}

func saveGameHistory(games: [Game]) {
    do {
        let file = try getHistoryFilePath()
        if NSKeyedArchiver.archiveRootObject(games, toFile: file.path) {
            print("Saved History @ \(file)")
        }
    } catch {
        print("\(error)")
    }
}

func startTicTacToe(){
    var gameArray: [Game] = loadSavedGames()
    print("Welcome to TicTacToe!")
    let player1 = Player(name: getStringFromTheUser(prompt: "What is player one's name?"), mark: .x)
    let player2 = Player(name: getStringFromTheUser(prompt: "What is player two's name?"), mark: .o)
    gameArray.append(gamePlay(players: (player1, player2)))
    let currentGame = gameArray.count - 1
    var wantANewRound = getStringFromTheUser(prompt: "Would you like to play a new round? y for Yes n for No")
    while evaluateYN(input: wantANewRound) {
        let newPlayers = getStringFromTheUser(prompt: "Would you like to keep the same players? y for Yes n for No")
        if evaluateYN(input: newPlayers){
            let newGame = gamePlay(players: (gameArray[currentGame].player1, gameArray[currentGame].player2))
            gameArray.append(newGame)
        } else {
            let player1 = Player(name: getStringFromTheUser(prompt: "What is player one's name?"), mark: .x)
            let player2 = Player(name: getStringFromTheUser(prompt: "What is player two's name?"), mark: .o)
            gameArray.append(gamePlay(players: (player1, player2)))
        }
        wantANewRound = getStringFromTheUser(prompt: "Would you like to play a new round? y for Yes n for No")
    }
    
    saveGameHistory(games: gameArray)
    
    for i in gameArray {
        print("\(i.player1.name) vs \(i.player2.name)")
        if i.gameOutCome == .player1Wins{
            print("\(i.player1.name) Wins")
        } else if i.gameOutCome == .player2Wins {
            print("\(i.player2.name) Wins")
        } else {
            print("It was a draw!")
        }
    }
    
}








