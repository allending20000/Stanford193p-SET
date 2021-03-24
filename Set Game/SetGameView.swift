//
//  ContentView.swift
//  Set Game
//
//  Created by Allen Ding on 3/22/21.
//

import SwiftUI

//View for the Set game
struct SetGameView: View {
    //ViewModel
    @ObservedObject var viewModel: SetGameVM
    
   var body: some View {
        //Reading the entire size of the screen to generate a random spot offscreen for transitioning of the cards
        GeometryReader {geometry in
            VStack {
                //Title of the game
                Text("SET").font(.largeTitle)
                //Current status of the game
                if viewModel.isASet {
                    Text("Great! It's a SET!").font(.title2)
                } else if viewModel.picked.count == 3 {
                    Text("Not a SET. Try Again!").font(.title2)
                } else {
                    Text("Selecting Cards...").font(.title2)
                }
                //Button to deal 3 more cards
                Button("Deal 3 More Cards") {
                    withAnimation(.linear(duration: creatingAndDealingDuration)) {
                        viewModel.dealThreeMore()
                    }
                }
                    //disable button if there are less than 3 cards in the deck
                    .disabled(viewModel.deck.count < 3)
                //Grid of all our cards
                Grid(items: viewModel.hand) {card in
                    ZStack {
                        //Each card
                        CardView(card: card)
                            .onTapGesture {
                                withAnimation(.linear(duration:choosingCardDuration)) {
                                    viewModel.choose(card: card)
                                }
                            }
                        //Highlights a different color (green/red/yellow) based on status
                        //(picked cards form a SET/picked cards don't form a SET/still picking cards)
                        if viewModel.picked.contains(card) {
                            Group {
                                //green background if selected cards is a set
                                if viewModel.isASet {
                                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.green)
                                //red background if 3 picked cards is not set
                                } else if viewModel.picked.count == 3 {
                                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.red)
                                //yellow background if selected less than 3 cards
                                } else {
                                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.yellow)
                                }
                            }
                            .opacity(opacity)
                        }
                    }
                    .aspectRatio(desiredAspectRatio, contentMode: .fit)
                    .padding()
                    //Causes our cards to fly off/on screen to/from a random location offscreen for "dealing" effect
                    .transition(AnyTransition.offset(generateRandomSize(size: geometry.size)))
                }
                //Causes views for cards in hand to appear upon beginning the game for the initial "dealing" effect
                .onAppear {
                    withAnimation(.linear(duration: creatingAndDealingDuration)) {
                        //Change to model causes card views to appear after container view
                        viewModel.generateHand()
                    }
                }
                //Button to start a new game
                Button("New Game"){
                    withAnimation(.linear(duration: creatingAndDealingDuration)) {
                        viewModel.createSetGame()
                    }
                }
            }
        }
    }
    
    //generates a random CGSize off the screen
    func generateRandomSize(size: CGSize) -> CGSize {
        let randomCGFloat = CGFloat.random(in: 500...1000)
        return CGSize(width: randomCGFloat, height: size.height + randomCGFloat)
    }
    
    // MARK: - Drawing Constants
    var cornerRadius: CGFloat = 6
    var lineWidth: CGFloat = 3
    var opacity = 0.2
    var desiredAspectRatio: CGFloat = 1
    var creatingAndDealingDuration = 1.0
    var choosingCardDuration = 0.5
}

struct CardView: View{
    var card: SetGameVM.SetGameType.Card
    
    var body: some View {
        ZStack {
            //Drawing the borders of card
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
            //Drawing the contents of each card (shape/color/shading/number of items)
            let shapeView = CardShapeView(cardShape: card.shape)
            let colorAndShadingView = CardColorAndShadingView(cardColor: card.color, cardShading: card.shading, itemShape: shapeView)
            CardRangeView(cardRange: card.number, itemView: colorAndShadingView)
                .padding(contentPadding)
        }
        //Color of card border
        .foregroundColor(foregroundColor)
    }
    
    // MARK: - Drawing Constants
    var cornerRadius: CGFloat = 6
    var lineWidth: CGFloat = 3
    var contentPadding: CGFloat = 9
    //Choose foreground color based on color of the card
    var foregroundColor: Color {
        if card.color == .blue {
            return Color.blue
        } else if card.color == .pink {
            return Color.pink
        } else {
            return Color.green
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameVM())
    }
}
