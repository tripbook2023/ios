//
//  TravelNewsPostViewModel.swift
//  ios-tripbook
//
//  Created by RED on 2023/10/04.
//

import SwiftUI
import Combine
import RichTextKit

class TravelNewsPostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var textContent: NSAttributedString = .init(string: "")
    @Published var context = RichTextContext()
    
    init(title: String, textContent: NSAttributedString) {
        self.title = title
        self.textContent = textContent
    }
    
    func extract() {
        let result = textContent.attributedString2Html
        print(result)
    }
}

extension NSAttributedString {
    var attributedString2Html: String? {
        do {
            let htmlData = try self.data(from: NSRange(location: 0, length: self.length), documentAttributes:[.documentType: NSAttributedString.DocumentType.html]);
            return String.init(data: htmlData, encoding: String.Encoding.utf8)
        } catch {
            print("error:", error)
            return nil
        }
    }
}
