//
//  NSAttributedString+Extension.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/08.
//

import Foundation

extension NSAttributedString {
    func toHTML() -> String? {
        do {
            let options: [NSAttributedString.DocumentAttributeKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let data = try self.data(from: NSRange(location: 0, length: self.length), documentAttributes: options)
            if let htmlString = String(data: data, encoding: .utf8) {
                return htmlString
            }
        } catch {
            print("Error converting NSAttributedString to HTML: \(error)")
        }
        return nil
    }
}
