//
//  NSAttributedString+Extension.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/08.
//

import Foundation

extension NSAttributedString {
    func toImageTag(dic: [Int: String]) -> ([String], Set<Int>) {
        var arr: [String] = []
        var usedIds: Set<Int> = []
        self.enumerateAttribute(
            .init("ID"),
            in: NSRange(location: 0, length: self.length), options: []
        ) { value, range, _ in
            if let id = value as? Int {
                if let urlString = dic[id] {
                    arr.append("<img id=\(id) style=\"border-radius:12.56px; margin-top: 20px; margin-bottom: 20px\" src=\"\(urlString)\" width=\"335\">")
                    usedIds.insert(id)
                }
            }
        }
        return (arr, usedIds)
    }
    
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
