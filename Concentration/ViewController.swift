//
//  ViewController.swift
//  Concentration
//
//  Created by Lashaun Corinna on 11/23/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    private func updateTouches() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 3.0,
            .strokeColor: UIColor.red
        ]
        let attributesString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
        touchLabel.attributedText = attributesString
    }
    
    private(set) var touches: Int = 0 {
        didSet {
            updateTouches()
        }
    }
    
    private var emojiCollection = "🦧🦍🐓🦫🐲🐁🦌🦓🐊🐋🦭🦐🦈🤡🐐"
    
    private var emojiDictionary = [Card:String]()
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            let randomStringIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4randomExtension)
            emojiDictionary[card] = String(emojiCollection.remove(at: randomStringIndex))
        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = .white
                button.titleLabel?.font = .systemFont(ofSize: 50)
            } else {
                button.setTitle("", for: .normal)
                //                button.backgroundColor = card.isMatched ? UIColor(white: 1.0, alpha: 0.7) : .systemBlue
                button.backgroundColor = card.isMatched ? .white : .systemBlue
            }
        }
    }
    
    private func checkingEndGame() {
        var j = 0
        for i in 0..<buttonCollection.count {
            if buttonCollection[i].backgroundColor == .white {
                j += 1
            }
        }
        if j == (buttonCollection.count - 2) {
            touchLabel.text = "You have won!"
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet {
            updateTouches()
        }
    }
    
    @IBAction private func buttonAction(_ sender: UIButton) {
        if touchLabel.text == "You have won!" {
            return
        }
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
            checkingEndGame()
        }
    }
}

extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
