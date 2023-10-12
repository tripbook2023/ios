//
//  TravelNewsPostViewModel.swift
//  ios-tripbook
//
//  Created by RED on 2023/10/04.
//

import SwiftUI
import Combine

class TravelNewsPostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var textContent: NSAttributedString = .init(string: "")
    
    init(title: String, textContent: NSAttributedString) {
        self.title = title
        self.textContent = textContent
    }
}
