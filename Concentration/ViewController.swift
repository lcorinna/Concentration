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
            touchLabel.text = "Touches: \(touches)"
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
                button.backgroundColor = card.isMatched ? UIColor(white: 1.0, alpha: 0.7) : .systemBlue
            }
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet {
            updateTouches()
        }
    }
    
    private func gameOver() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            button.setTitle(emojiIdentifier(for: card), for: .normal)
            button.backgroundColor = .white
            button.titleLabel?.font = .systemFont(ofSize: 50)
        }
        let vc = SecondViewController(resultOfTouches: touches)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func buttonAction(_ sender: UIButton) {
        if game.numberOfPairsThatDidNotMatch == 0 {
            gameOver()
            return
        }
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
            if game.numberOfPairsThatDidNotMatch == 0 {
                gameOver()
            }
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
