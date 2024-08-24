//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mykola Chaikovskyi on 24.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.purple
            VStack {
                ZStack {
                    VStack(spacing: 0) {
                        Color.blue
                        Color.yellow
                    }
                    Text("My content")
                        .padding(50)
                        .foregroundStyle(.secondary)
                        .background(.ultraThinMaterial)
                }
                ZStack {
                    Color.indigo
                        .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
                    Text("My content")
                }
                ZStack {
                    Color.primary
                        .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
                    Text("My content")
                        .background(.secondary)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
