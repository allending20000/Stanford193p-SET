//
//  SetGame.swift
//  Set Game
//
//  Created by Allen Ding on 3/22/21.
//

import Foundation

// Model for the Set game
// struct so that changes can be easily detectable (for @Published)
struct SetGame<CardShape, CardColor, CardRange, CardShading> where CardShape: CaseIterable & Hashable & Equatable, CardColor: CaseIterable & Hashable & Equatable, CardShading: CaseIterable & Hashable & Equatable, CardRange: CaseIterable & Hashable & Equatable{
    
    //Deck of cards, not including those in the hand
    var deck = [Card]()
    //Current hand of cards
    var hand = [Card]()
    //Currently picked cards
    var picked = [Card]()
    
    //initialize all 81 cards
    init() {
        //unique id for each card
        var counter = 0
        for shape in CardShape.allCases {
            for color in CardColor.allCases {
                for shading in CardShading.allCases {
                    for number in CardRange.allCases{
                        deck.append(Card(shape: shape, color: color, number: number, shading: shading, id: counter))
                        counter += 1
                    }
                }
            }
        }
    }
    
    //Shuffles deck and generates a random hand of 12 cards
    mutating func generateHand() {
        deck.shuffle()
        hand = Array(deck[0..<12])
        deck.removeSubrange(0..<12)
    }
    
    //Choose a card from the hand
    //If there are already 3 cards selected, replace them if they form a set
    //If same card is chosen again, deselect the card
    mutating func choose(card: Card) {
        if picked.count != 3 && picked.contains(card) {
            deselect(card: card)
            return
        } else if picked.count == 3 {
            if isASet() {
               replaceSet()
            }
            picked = []
        }
        picked.append(card)
    }
    
    //Deselect a card from the hand
    mutating func deselect(card: Card) {
        picked.remove(at: picked.firstIndex(of: card)!)
    }
    
    //Returns if currently picked cards is a Set
    func isASet() -> Bool {
        if picked.count != 3 {
            return false
        } else {
            var shapeSet = Set<CardShape>()
            var colorSet = Set<CardColor>()
            var numberSet = Set<CardRange>()
            var shadingSet =  Set<CardShading>()
            for card in picked {
                shapeSet.insert(card.shape)
                colorSet.insert(card.color)
                numberSet.insert(card.number)
                shadingSet.insert(card.shading)
            }
            return shapeSet.validSet && colorSet.validSet && numberSet.validSet && shadingSet.validSet
        }
    }
    
    //Deals 3 more cards from the deck to the hand
    //If picked cards already form a set, replace those cards. Otherwise, deal 3 more cards.
    mutating func dealThreeMore() {
        if isASet() {
            replaceSet()
        } else {
            deck.shuffle()
            if deck.count > 2 {
                let deckLength = deck.count
                for i in 0..<3 {
                    let index = deckLength - i - 1
                    hand.append(deck[index])
                    deck.remove(at: index)
                }
            }
        }
    }
    
    //Replace matching cards in hand with new cards from the deck
    mutating func replaceSet() {
        deck.shuffle()
        for card in picked {
            hand.remove(at: picked.firstIndex(of: card)!)
        }
        for i in 0..<min(deck.count, 3) {
            hand.append(deck[i])
            deck.remove(at: i)
        }
        picked = []
    }
    
    // struct for each card of the game
    struct Card: Equatable, Identifiable{
        let shape: CardShape
        let color: CardColor
        let number: CardRange
        let shading: CardShading
        var id: Int
    }
}
