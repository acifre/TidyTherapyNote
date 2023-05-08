//
//  TitleRow.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/6/23.
//

import SwiftUI

struct TitleRow: View {
//    @EnvironmentObject var messagesManager: MessagesManager
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var chatBot: ChatBot
    @EnvironmentObject var note: Note
    @State private var showActionSheet = false
    @State private var showingPopover = false
    @State private var role = ""
    
    var name = "TidyTherapyNote"
    var body: some View {
        HStack(spacing: 20) {
            
            Image("therapy3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.white, lineWidth: 1)
                }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
             
            Button {
                showingPopover = true
                DispatchQueue.global(qos: .background).async {
                    // Perform some background task that updates myState
                    DispatchQueue.main.async {
                        self.chatBot.history = ""
                    }
                }
            } label: {
                Image(systemName: "note.text.badge.plus")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.black)
                    .cornerRadius(50)
            }
        }
        .padding()
        .popover(isPresented: $showingPopover) {

            NoteRequestFields()
                .environmentObject(note)
                .environmentObject(chatBot)
                .environmentObject(viewModel)
        }
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()
            .environmentObject(Note())
            .background(Color("Obsidian"))
            .preferredColorScheme(.dark)
    }
}

// <a href="https://www.freepik.com/free-vector/chat-bot-free-wallpaper-robot-holds-phone-responds-messages_4015732.htm#page=2&query=chat%20bot&position=14&from_view=search&track=ais">Image by roserodionova</a> on Freepik
