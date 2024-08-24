//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mykola Chaikovskyi on 24.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Button 1") {}
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) {}
                .buttonStyle(.bordered)
            Button("Button 3") {}
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
            Button("Button 4", role: .destructive) {}
                .buttonStyle(.borderedProminent)
            
            Button {
                print("Button was tapped.")
            } label: {
                Text("Tap me!")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
