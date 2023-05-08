//
//  ContentView.swift
//  TidyTherapy
//
//  Created by Anthony Cifre on 5/6/23.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @ObservedObject var chatHistory = ChatBot()
    @ObservedObject var note = Note()
    
    @State private var patientName = ""
    @State private var guardianName = ""
    @State var chatRole = "I want you to act as a psychology therapy note cleaner and editor. I will provide you with a therapy note for a patient. You should use your knowledge of cognitive behavioral therapy, acceptance-committment therapy, meditation techniques, mindfulness practices, and other therapeutic methods in order to edit the note to make it sound more professional and more concise (but not too concise). My first request is "
    @State var notes = [String]()

    
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                    .environmentObject(viewModel)
                    .environmentObject(chatHistory)
                    .environmentObject(note)
                    .background(Color("Obsidian"))
                

                    Text("Cleaned Note")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.black)
                        .border(.blue)
                    .cornerRadius(10)
                    
                    ScrollView {
                        Text(note.cleanText)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background()
                    .cornerRadius(30)
                    .padding()
//                }


            }

            .background(Color("Obsidian"))
        }
        .onAppear {
            viewModel.setup()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static
    var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

// TODO:
// - Finish UI of app
// - Add animation when response is loading
// - Make it so that chat input pops out to better read input
// - Create a field to change role for the bot
// - Create a settings page to change number of tokens, hold a role, change from light to dark mode
// - Create a button to clear the chat
