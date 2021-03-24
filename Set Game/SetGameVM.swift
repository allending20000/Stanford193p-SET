//
//  SetGameVM.swift
//  Set Game
//
//  Created by Allen Ding on 3/22/21.
//

import Foundation

//ViewModel for the Set game
class SetGameVM: ObservableObject{
    //Model
    @Published private var game = SetGameVM.createNewSetGame()
    //Theme for this game
    typealias SetGameType = SetGame<DefaultShapes, DefaultColors, DefaultRange, DefaultShadings>
    typealias shapes = DefaultShapes
    typealias colors = DefaultColors
    typealias range = DefaultRange
    typealias shadings = DefaultShadings
    
    // MARK: - Access to the Model
    //access to deck
    var deck: [SetGameType.Card] {
        game.deck
    }
    //access to hand
    var hand: [SetGameType.Card] {
        game.hand
    }
    //access to picked cards
    var picked: [SetGameType.Card] {
        game.picked
    }
    //returns if currently picked cards is a set
    var isASet: Bool {
        game.isASet()
    }
    

    // MARK: - Intent(s)
    func choose(card: SetGameType.Card) {
        game.choose(card: card)
    }
    
    //Initially creates the Set game
    //does not generate hand in order to animate the cards initially flying on screen when the game starts
    static func createNewSetGame() -> SetGameType {
        return SetGame()
    }
    
    //Creating a new instance of the Set game
    func createSetGame() {
        game = SetGameVM.createNewSetGame()
        game.generateHand()
    }
    
    //shuffles cards in the hand
    func shuffle() {
        game.hand.shuffle()
    }
    
    //generates a random hand of 12 cards
    func generateHand() {
        game.generateHand()
    }
    
    //deals three more cards
    func dealThreeMore() {
        game.dealThreeMore()
    }
}

enum DefaultShapes: CaseIterable {
    case diamond, squiggle, oval
}

enum DefaultColors: CaseIterable  {
    case pink, blue, green
}

enum DefaultShadings: CaseIterable  {
    case solid, striped, open
}

enum DefaultRange: CaseIterable {
    case one, two, three
}
