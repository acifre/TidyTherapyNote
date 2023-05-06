//
//  ContentView.swift
//  TidyTherapy
//
//  Created by Anthony Cifre on 5/6/23.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var viewmodel = ViewModel()
    @State private var patientName = ""
    @State private var guardianName = ""
    @State var chatRole = "I want you to act as a psychology therapy note cleaner and editor. I will provide you with a therapy note for a patient. You should use your knowledge of cognitive behavioral therapy, acceptance-committment therapy, meditation techniques, mindfulness practices, and other therapeutic methods in order to edit the note to make it sound more professional and more concise (but not too concise). My first request is "
    @State var dirtyNote = ""
    @State var currentRequest = ""
    @State var cleanedNote = ""
    @State var notes = [String]()
    var body: some View {
        NavigationView {
            VStack {
                Text("Dirty Note")
                    .padding(1)
                ScrollView {
                    Text(currentRequest)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .border(.black)
                .cornerRadius(5)
                .padding()
                
                Text("Cleaned Note")
                    .padding(1)
                ScrollView {
                    Text(cleanedNote)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .border(.black)
                .cornerRadius(5)
                .padding()
                
                VStack {
                    HStack {
                        TextField("Patient's Name", text: $patientName)
                            .textFieldStyle(.roundedBorder)
                            .border(.black)
                            .padding()
                        TextField("Guardian's Name", text: $guardianName)
                            .textFieldStyle(.roundedBorder)
                            .border(.black)
                            .padding()
                    }
                    HStack {
                        TextField("Enter your note text", text: $dirtyNote, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .border(.blue)
                            .padding()

                    }
                    Button("Send") {
                        send()
                    }
                    .frame(width: 100, height: 40).background(.blue)
                    .foregroundColor(.white)
                    .font(.title3)
                    .cornerRadius(12)
                }
                    .padding(.horizontal)
                .navigationTitle("TidyTherapyNote")
            }
        }
        .onAppear {
            viewmodel.setup()
        }
    }
    func send() {
        guard !dirtyNote.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return
        }
        notes.append("Me: \n\n\(dirtyNote.trimmingCharacters(in: .whitespaces)) \n")
        self.currentRequest = dirtyNote.trimmingCharacters(in: .whitespaces)
        viewmodel.send(text: chatRole + dirtyNote.replacingOccurrences(of: patientName, with: "Anthony", options: .caseInsensitive)) {
            result in print(result)
            self.notes.append("Cleaned Note: \n" + result)
            self.cleanedNote = result.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        self.dirtyNote = ""
        self.patientName = ""
    }
}
struct ContentView_Previews: PreviewProvider {
    static
    var previews: some View {
        ContentView()
    }
}

// TODO:
// - Save conversations
// - Make my text and chatbot text distinguishable
// - Have bot remember previous three rounds of conversation
// - Add animation when response is received
// - Create a field to hold a role for the bot
// - Create a settings page to change number of tokens, hold a role, change from light to dark mode
// - Create a button to clear the chat
