//: Playground - noun: a place where people can play
import Foundation
import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = containerView

let paragraph = NSMutableParagraphStyle()
paragraph.alignment = .center

let attributes = [NSAttributedStringKey.paragraphStyle: paragraph, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17.0)]

let fullText =  NSMutableAttributedString(string: "Keep your kids on track by  checking out the list of your children's homework each night. Homework is marked with {icon}", attributes: attributes)

// range of substring to search
let str1 = fullText.string as NSString
let range = str1.range(of: "{icon}")

if range.location != NSNotFound {
    let textView = UITextView(frame: CGRect(x: 50, y: 10, width: 280, height: 102))
    textView.font = UIFont.systemFont(ofSize: 17)
    textView.backgroundColor = UIColor.white
    textView.textAlignment = .center
    textView.attributedText = fullText
    containerView.addSubview(textView)
    
    // you should ensure layout
    textView.layoutManager.ensureLayout(for: textView.textContainer)
    
    // text position of the range.location
    let start = textView.position(from: textView.beginningOfDocument, offset: range.location)!
    
    // text position of the end of the range
    let end = textView.position(from: start, offset: range.length)!
    
    // text range of the range
    let tRange = textView.textRange(from: start, to: end)
    
    // here it is!
    let rect = textView.firstRect(for: tRange!)
    
    let view = UIView(frame: CGRect(x: rect.minX, y: rect.minY+2, width: rect.width, height: rect.height-2))
    view.backgroundColor = UIColor.white
    
    let homeworkView = HomeworkView(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.height))
    homeworkView.backgroundColor = UIColor.white
    homeworkView.layer.cornerRadius = 3
    homeworkView.layer.borderColor = UIColor.purple.cgColor
    homeworkView.layer.borderWidth = 1.0
    
    view.addSubview(homeworkView)
    
    textView.addSubview(view)
}

class HomeworkView: UIView {
    override func draw(_ rect: CGRect) {
        let str = "Homework"
        let index = str.index(str.startIndex, offsetBy: 0)
        
        let textRect = CGRect(x: 4.5, y: rect.minY, width: rect.width, height: rect.height)
        drawMyText(myText: "\(str[index])", textColor: UIColor.purple, inRect: textRect)
    }
    
    func drawMyText(myText:String,textColor:UIColor, inRect:CGRect){
        let attributes = [NSAttributedStringKey.foregroundColor: textColor, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17.0)]
        
        myText.draw(in: inRect, withAttributes: attributes)
    }
}
