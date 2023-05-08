//
//  Note.swift
//  TidyTherapyNote
//
//  Created by Anthony Cifre on 5/7/23.
//

import Foundation

class Note: ObservableObject {
    @Published var patientName = ""
    @Published var guardianName = ""
    @Published var dirtyText = ""
    @Published var cleanText = ""
}
