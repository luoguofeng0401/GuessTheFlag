//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Guofeng Luo on 2026-04-18.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Monaco", "US", "Russia"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var questions = 0
    

    

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))

                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Questions \(questions) : Your score is \(score)")
        }
 
    }
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        questions += 1
        showingScore = true
    }
    
    func askQuestion() {
        if questions < 8 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            
            score = 0
            questions = 0
            
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        
    }
    
}

#Preview {
    ContentView()
}
