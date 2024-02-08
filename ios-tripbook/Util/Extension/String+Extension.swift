//
//  String+Extension.swift
//  ios-tripbook
//
//  Created by 이시원 on 1/24/24.
//

import Foundation

extension String {
    func toAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil
        )
    }
}
