//
//  NSAttributedString+Extension.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/08.
//

import Foundation
import UIKit

extension NSAttributedString {
    func toImageTag(dic: [Int: String]) -> [String] {
        var arr: [String] = []
        self.enumerateAttribute(.init("ID"), in: NSRange(location: 0, length: self.length), options: []) { value, range, _ in
            if let id = value as? Int {
                if let urlString = dic[id] {

                    arr.append("<div style=\"text-align: center;\"><img src=\"\(urlString)\" style=\"width: 80%; height: auto; border-radius: 20px;\"></div>")
                }
            }
        }
        return arr
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
