//
//  TileGame.swift
//  TileGame
//
//  Created by Tal Weiss on 4/12/16.
//  Copyright © 2016 Tal Weiss. All rights reserved.
//
//CODE WAS WRITTEN WITH SWIFT 2.2
import Foundation

struct node{
    var emoji:String// string containing the emoji
    var matched: Bool//checks to see if matched with the same emoji
    //var boardRow: Int//stores the board row of the emoji
    //var boardColumn: Int//stores the board column of the emoji
    
}
// a class for the game where the board will be initialized
class TileGame{
    var board = [[node]]()//the board itself
    var boardRow = [node]()//the board row
    let boarditems = ["🇨🇦","🇨🇦","🇹🇷","🇹🇷","🇨🇭","🇨🇭","🇮🇱","🇮🇱","🇺🇸","🇺🇸","🇳🇱","🇳🇱","🇮🇳","🇮🇳","🇦🇺","🇦🇺","🇷🇺","🇷🇺","🇬🇧","🇬🇧"]//emoji array
    var index = 0
    

    
    init(){//board is created here
        let shuffledBoardItems = generateBoard(list: boarditems);
        print(shuffledBoardItems)//shows the shuffled list for debuggin purposes
        for _ in 0...4{
            boardRow = [node]()//initializes a new row for our board
            for _ in 0...3{
                boardRow.append(node(emoji: shuffledBoardItems[index], matched: false))//appends a new node into our board
                index += 1 // increments index to access the next index in our shuffledBoardItems array
            }
        board.append(boardRow)
        }
        
        printboard()//calls function to print out the board (debugging purposes)
    }
    
    //Helper function to randomly genereate a string array for the board
    func generateBoard(list: [String]) -> [String]{
        var randomGenBoard = [String]();
        var itemsCounted: Int = 0;
        var itemsSeen = [Int:Bool]()
        
//        populate dictionary initially with false statements indicating the index hasn't been used yet
        for i in 0...list.count-1{
            itemsSeen[i] = false;
        }
        while(itemsCounted <= list.count-1){
            let index = Int.random(in: 0..<list.count);
            if(!itemsSeen[index]!){
                randomGenBoard.append(list[index]);
                itemsSeen[index] = true;
                itemsCounted+=1;
            }
        }
        return randomGenBoard;
        
    }

    
    func getTile(_ buttonTag: Int) -> String{//function to get the tile within the array
        let boardRow = buttonTag / 4//gives access to board row
        let boardColumn = buttonTag % 4//gives access to button colomn
        print("returning tile at \(board[boardRow][boardColumn])")
        return board[boardRow][boardColumn].emoji
        
    }
    func CompareEmojis(_ buttonTag1: Int, buttonTag2: Int) -> Bool{//compares the two emojis the user pressed in the view
        //compares two buttons
        let boardRow1 = buttonTag1 / 4//regular division to obtain board row
        let boardCol1 = buttonTag1 % 4//modulo division to obtain board column
        let boardRow2 = buttonTag2 / 4
        let boardCol2 = buttonTag2 % 4
        print("comparing \(board[boardRow1][boardCol1].emoji) with \(board[boardRow2][boardCol2].emoji)")
        if board[boardRow1][boardCol1].emoji == board[boardRow2][boardCol2].emoji{
            //compares the two emojis accessed within the boards
            print("emojis match")
            board[boardRow1][boardCol1].matched = true
            print(board[boardRow1][boardCol1])
            board[boardRow2][boardCol2].matched = true
            print(board[boardRow2][boardCol2])
            printboard()
            return true
        }
        else{
            print("does not match")
            printboard()
            return false
        }
        
    }
    
    func printboard(){//function to print the board 
        var count = 0
        for row in board{
            print(row)
            for _ in row{
                count+=1
            }
        }
        print("List Contains \(count)/20 elements")
    }
    
    func decrementMovesLeft(_ movesLeft:String) -> String{//decrements moves left
        var IntMovesLeft = Int(movesLeft)//converts to integer to do the arithmetic
        IntMovesLeft! -= 1
        return String(IntMovesLeft!)
    }
    func incrementMovesUsed(_ movesUsed:String) -> String{//increments moves used
        var IntMovesUsed = Int(movesUsed)
        IntMovesUsed! += 1
        return String(IntMovesUsed!)
    }
    
    func gameOver() -> Bool{
        var count = 0 //keeps track of all the matched tiles
        var allMatched = false //boolean value that will be returned to controller
        for row in board{
            for item in row{
                //for every node with the matched property set to true
                //count will be incremented by 1
                print("Checking -> \(item)")
                if item.matched == true{
                    count+=1
                }
                
            }
        }
        print("total number of matches \(count)/20")
        
        //at the end of the loop check to see if count is at 20 (use a switch statement)
        switch count {
        case 0..<19:
            print("you haven't gotten all the tiles")
            allMatched = false
        case 20:
            print("you got all the tiles")
            allMatched = true
        default:
            print("this is the default statement")
        }
        return allMatched // returns the boolenan value
    }
        

}



