//
//  ChatBot.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/7/23.
//

import Foundation
import SwiftUI

class ChatBot: ObservableObject {
    @Published var history = ""
    @Published var role = "" 
    @Published var tokens = 500
    @Published var turns = 3
    
    static var firstRole = "I want you to act as a psychology therapy note cleaner and editor. I will provide you with a therapy note for a patient. You should use your knowledge of cognitive behavioral therapy, acceptance-committment therapy, meditation techniques, mindfulness practices, and other therapeutic methods in order to edit the note to make it sound more professional and more concise (but not too concise). My first request is "
}
