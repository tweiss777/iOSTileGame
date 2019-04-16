//: Playground - noun: a place where people can play
import XCPlayground
import UIKit
var str = "Hello, playground"
let screen = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
let button = UIButton(frame:CGRectMake(40, 250, 240, 100))//initializes the button itself
let buttonLabel = UILabel()//initializes the reset button label
button.backgroundColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
buttonLabel.frame = CGRectMake(130, 285, 220, 100)
buttonLabel.textColor = UIColor.whiteColor()
buttonLabel.text = "            Press to Reset"
button.center = screen.center
buttonLabel.center = screen.center

screen.addSubview(button)
screen.addSubview(buttonLabel)

XCPlaygroundPage.currentPage.liveView = screen
