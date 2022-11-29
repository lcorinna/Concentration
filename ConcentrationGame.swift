//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Lashaun Corinna on 11/24/22.
//

import Foundation

class ConcentrationGame {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex] == cards[index] {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "ConcentrationGame.init(\(numberOfPairsOfCards): must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            
        }
                cards.shuffle() // mix
    }
    
//    func checkingEndGame(numberOfCards: Int) {
//        var i = 0
//        var j = 0
//        for _ in 1...numberOfCards {
//            print(cards[i].isFaceUp) //del
//            if cards[i].isFaceUp == true {
//                j += 1
//            }
//            i += 1
//        }
//        print("i - \(i)") //del
//        if j == numberOfCards {
//            print("end")
//        } else {
//            print("no end")
//            print("j = \(j) and numberOfCards = \(numberOfCards)")
//            print("")
//        }
//    }
//}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
