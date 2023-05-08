//
//  ViewModel.swift
//  TidyTherapy
//
//  Created by Anthony Cifre on 5/6/23.
//

import Foundation
import OpenAISwift

public class ViewModel: ObservableObject {
    init() {}
    private
    var client: OpenAISwift?; func setup() {
        client = OpenAISwift(authToken: UsefulValues.APIKey)
    }
    func send(text: String, completion: @escaping(String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: {
            result in
            switch result {
            case.success(let model): let output = model.choices?.first?.text ?? ""
                completion(output)
                case.failure(_): break
            }
        })
    }
}
