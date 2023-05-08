//
//  NoteRequestFields.swift
//  TidyTherapyNote
//
//  Created by Anthony Cifre on 5/7/23.
//

import SwiftUI

struct NoteRequestFields: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var note: Note
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatBot: ChatBot
    
    @State private var patientName = ""
    @State private var guardianName = ""
    @State private var dirtyNote = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Patient's Name", text: $patientName)
                    .textFieldStyle(.roundedBorder)
                    .border(.primary)
                    .cornerRadius(2)
                    .padding(1)
                TextField("Guardian's Name", text: $guardianName)
                    .textFieldStyle(.roundedBorder)
                    .border(.primary)
                    .cornerRadius(2)
                    .padding(1)
            }
            HStack {
                TextField("Enter your note text", text: $dirtyNote, axis: .vertical)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(.primary)
                    .cornerRadius(2)
                    .padding(1)

            }
            Button("Send") {
                note.patientName = patientName
                note.guardianName = guardianName
                note.dirtyText = dirtyNote
                send()
                dismiss()
            }
            .frame(width: 100, height: 40).background(.blue)
            .foregroundColor(.primary)
            .font(.title3)
            .cornerRadius(12)
        }
        .padding()
    }
    
    func send() {
        guard !dirtyNote.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return
        }
        viewModel.send(text: ChatBot.firstRole + dirtyNote.replacingOccurrences(of: patientName, with: "John", options: .caseInsensitive)) {
            result in print(result)
            
            DispatchQueue.global(qos: .background).async {
                // Perform some background task that updates myState
                DispatchQueue.main.async {
                    self.note.cleanText.append(result.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "John", with: patientName))
                }
            }
            

        }
                                       
    }
}

struct NoteRequestFields_Previews: PreviewProvider {
    static var previews: some View {
        NoteRequestFields()
            .preferredColorScheme(.dark)
    }
}
