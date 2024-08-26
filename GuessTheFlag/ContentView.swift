//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mykola Chaikovskyi on 24.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var playerScore = 0
    @State private var scoreAlertMessage = ""
    
    @State private var currentQuestion = 0
    @State private var showEndGameAlert = false
    
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
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 5 )
                        }
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
