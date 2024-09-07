//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mykola Chaikovskyi on 24.08.2024.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    
    init(_ image: String) {
        self.image = image
    }
    
    var body: some View {
        Image(image)
            .clipShape(Capsule())
            .shadow(radius: 5 )
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var playerScore = 0
    @State private var scoreAlertMessage = ""
    
    @State private var currentQuestion = 1
    @State private var showEndGameAlert = false
    
    @State private var flagSelected = -1
    @State private var spinAnimationCapacity = 0.0
    @State private var inactiveFlagsOpacity = 1.0
    @State private var inactiveFlagsScale = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init (color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top , startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
             
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countries[number])
                        }
                        .rotation3DEffect(.degrees(number == flagSelected ? spinAnimationCapacity : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number == flagSelected || flagSelected == -1 ? 1 : inactiveFlagsOpacity)
                        .animation(.default, value: inactiveFlagsOpacity)
                        .scaleEffect(number == flagSelected || flagSelected == -1 ? 1.0 : inactiveFlagsScale)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                 Text("Score: \(playerScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreAlertMessage)
        }
        .alert("Game over", isPresented: $showEndGameAlert) {
            Button("New game", action: resetGame)
        } message: {
            Text("Your final score is \(playerScore).\nThank you for playing!")
        }
    }
    
    func flagTapped(_ number: Int) {
        flagSelected = number
        withAnimation {
            spinAnimationCapacity = 360
        }
        inactiveFlagsOpacity = 0.25
        withAnimation(.easeInOut(duration: 2)) {
            inactiveFlagsScale = 0.25
        }
        scoreAlertMessage = ""
        if number == correctAnswer {
            scoreTitle = "Correct"
            playerScore += 1
        }
        else {
            scoreTitle = "Wrong"
            scoreAlertMessage = "Wrong! That is the flag of \(countries[number])!\n"
        }
        scoreAlertMessage += "Your score is \(playerScore)."
        
        if currentQuestion >= 8 {
            showEndGameAlert = true
        }
        else {
            showScore = true
        }
    }
    
    func askQuestion() {
        currentQuestion += 1
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        spinAnimationCapacity = 0
        inactiveFlagsScale = 1
        flagSelected = -1
    }
    
    func resetGame() {
        currentQuestion = 0
        playerScore = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
