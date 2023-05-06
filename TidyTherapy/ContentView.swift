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
    @State var text = ""
    @State var notes = [String]()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(notes, id: \.self) {
                        string in HStack {
                            Text(string)
                        }
                    }
                    Spacer()
                    VStack {
                        HStack {
                            TextField("Patient's Name", text: $patientName)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                            TextField("Guardian's Name", text: $guardianName)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                        }
                        HStack {
//                            Image("therapy")
//                                .resizable()
//                                .frame(width: 40, height: 40)
                            TextField("Enter your note text", text: $text, axis: .vertical)
                                .textFieldStyle(.roundedBorder)
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
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return
        }
        notes.append("Me: \n\n\(text.trimmingCharacters(in: .whitespaces)) \n")
        viewmodel.send(text: chatRole + text.replacingOccurrences(of: patientName, with: "Anthony")) {
            result in print(result)
            self.notes.append("Cleaned Note: \n" + result)
        }
        self.text = ""
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
