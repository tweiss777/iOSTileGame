//
//  ViewController.swift
//  TileGame
//
//  Created by Tal Weiss on 4/11/16.
//  Copyright © 2016 Tal Weiss. All rights reserved.
//
//CODE WAS WRITTEN WITH SWIFT 2.2

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        movesLeft.text = "\(25)"//sets movesLeft to 25
        movesUsed.text = "\(0)"//sets movesUsed to 0
        outCome.text = ""
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {//prevents app from going into landscape mode
        return UIInterfaceOrientationMask.portrait
    }
    

    @IBOutlet weak var outCome: UILabel!
    @IBOutlet weak var movesUsed: UILabel!//Label for moves used
    @IBOutlet weak var movesLeft: UILabel!//Label for moves left
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printButtonsPressed(){//prints tags pressed
        for button in buttonsPressed{
            print(button.tag)
        }
    }
    //Funtion for an ingame reset button
    @IBAction func InGameReset(_ sender: UIButton){
        myTileGame = TileGame.init()// reinitializes the class which restarts the game
        movesLeft.text = "\(25)"//resets movesLeft to 25
        movesUsed.text = "\(0)"//resets movesUsed to 0
        outCome.text = ""//resets the outcome displayed back to blank
        for button in buttonsPressed{
            button.setBackgroundImage(image, for: UIControl.State())
            button.setTitle("", for: UIControl.State())
        }
        for button in buttonsMatched{
            button.setBackgroundImage(image, for: UIControl.State())
            button.setTitle("", for: UIControl.State())
        }
        buttonsMatched.removeAll()
        buttonsPressed.removeAll()
        //also fix the function to cover the tiles that are being compared
    }
    
    
    @objc func ResetGame(_ sender: UIButton!){//function to reset the game
        buttonLabel.text = ""//should remove the text from the resetbutton's text(UNTESTED)
        myTileGame = TileGame.init()// reinitializes the class which restarts the game
        movesLeft.text = "\(25)"//resets movesLeft to 25
        movesUsed.text = "\(0)"//resets movesUsed to 0
        outCome.text = ""//resets the outcome displayed back to blank
        for button in buttonsMatched{
            button.setBackgroundImage(image, for: UIControl.State())
            button.setTitle("", for: UIControl.State())
        }
        buttonsMatched.removeAll()
        buttonsPressed.removeAll()
        sender.removeFromSuperview()

    }
    
   func callResetButton(){//pops up the reset button
        let mainView = self.view
        //CODE FOR THE RESET BUTTON
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.backgroundColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
        button.center = (mainView?.center)!
        buttonLabel.frame = CGRect(x: 130, y: 285, width: 220, height: 100)
        buttonLabel.center = (mainView?.center)!
        buttonLabel.textColor = UIColor.white
        buttonLabel.text = "            Press to Reset"
    button.addTarget(self, action: #selector(ViewController.ResetGame(_:)), for: UIControl.Event.touchUpInside)
        mainView?.addSubview(button)
        mainView?.addSubview(buttonLabel)
        //CODE FOR RESET BUTTON ENDS HERE
        
    }
    let button = UIButton(frame:CGRect(x: 40, y: 250, width: 240, height: 100))//initializes the reset button itself
    let buttonLabel = UILabel()//initializes the reset button label
    var buttonsMatched = [UIButton]()//array that keeps track of all the buttons matched
    var buttonsPressed = [UIButton]()//keeps track of button tags
    var matched = false
    //creates the instance of the game
    var myTileGame = TileGame()
    
    let image = UIImage(named: "HiddenTile")//where our background is held
    @IBAction func RevealHiddenTile(_ sender: UIButton) {//this button reveals hidden emoji behind tile
        let currentEmoji = myTileGame.getTile(sender.tag)//stores node
        print("emoji \(currentEmoji)")//shows node info in console
        //used for debugging purposes
        //you have to click on the button to see john cena
        // otherwise you can't see him!!
        //you currently can see him!!
        if Int(movesLeft.text!) > 0 || outCome.text! == ""{
            if !buttonsPressed.contains(sender){
                if sender.currentBackgroundImage != nil{//will remove the background of the button if detected a.k.a you can't see him!!
                    sender.setBackgroundImage(nil, for: UIControl.State())
                    sender.setTitle(currentEmoji, for: UIControl.State())
                    buttonsPressed.append(sender)
                    printButtonsPressed()//prints buttons already pressed
                    if buttonsPressed.count == 2 {
                        matched = myTileGame.CompareEmojis(buttonsPressed[0].tag, buttonTag2: buttonsPressed[1].tag)
                        movesLeft.text = myTileGame.decrementMovesLeft(movesLeft.text!)//decrement moves left
                        movesUsed.text = myTileGame.incrementMovesUsed(movesUsed.text!)//increment moves used
                            myTileGame.printboard()//prints the board
                        //IF STATEMENTS FOR DETERMIING IF THE GAME IS OVER HAS BEEN UPDATED
                        
                        if myTileGame.gameOver() && Int(movesLeft.text!) > 0 {
                            print("Game over all tiles have been revealed")//used for debugging purposes
                            outCome.text = "You Win!!"
                            buttonsMatched.append(buttonsPressed[0])
                            buttonsMatched.append(buttonsPressed[1])
                            callResetButton()
                        }
                        if Int(movesLeft.text!) == 0 && myTileGame.gameOver(){
                            print("Game over all tiles have been revealed")//used for debugging purposes
                            outCome.text = "You Win!!"
                            buttonsMatched.append(buttonsPressed[0])
                            buttonsMatched.append(buttonsPressed[1])
                            callResetButton()
                            
                        }
                        
                        if Int(movesLeft.text!) == 0 && !myTileGame.gameOver(){
                            print("game over and you lose")
                            outCome.text = "Loser!!"
                            buttonsMatched.append(buttonsPressed[0])
                            buttonsMatched.append(buttonsPressed[1])
                            callResetButton()
                            
                        }
                        

                    }
                    if buttonsPressed.count > 2 {
                        if matched == false{
                            for i in 0...1{
                                buttonsPressed[i].setBackgroundImage(image, for: UIControl.State())
                                buttonsPressed[i].setTitle("", for: UIControl.State())
                            }
                            buttonsPressed.removeFirst()
                            buttonsPressed.removeFirst()
                        }
                        if matched == true{//removes buttons previously pressed but doesn't
                            //cover the emojis
                            buttonsMatched.append(buttonsPressed[0])
                            buttonsMatched.append(buttonsPressed[1])
                            buttonsPressed.removeFirst()
                            buttonsPressed.removeFirst()
                            //create an array that keeps track of all the tiles that have been matched 
                            //so when you get your reset button to work, you can cover the tiles again!!
                        }

                    }
                    
                }
            }
        }
    }
}
