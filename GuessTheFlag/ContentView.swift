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
            VStack {
                HStack {
                    Text("1")
                    Text("2")
                    Text("3")
                }
                HStack {
                    Text("4")
                    Text("5")
                    Text("6")
                }
                HStack {
                    Text("7")
                    Text("8")
                    Text("9")
                }
            }
            ZStack(alignment: .top) {
                Text("I am at the top")
                Text("Bottom guy")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
