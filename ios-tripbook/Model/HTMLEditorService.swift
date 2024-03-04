//
//  HTMLEditorService.swift
//  ios-tripbook
//
//  Created by RED on 2023/12/12.
//

import Foundation

class HTMLEditorService {
    
    func extractBodyContent(from htmlString: String) -> String? {
        let pattern = "(?<=<body>)([\\s\\S]*?)(?=</body>)"
        if let range = htmlString.range(of: pattern, options: .regularExpression) {
            let bodyContent = htmlString[range]
            return String(bodyContent)
        }
        return nil
    }

    func extractStyleContent(from htmlString: String) -> String? {
        if let startRange = htmlString.range(of: "<style type=\"text/css\">", options: .caseInsensitive),
           let endRange = htmlString.range(of: "</style>", options: .caseInsensitive, range: startRange.upperBound..<htmlString.endIndex) {
            let range = startRange.upperBound..<endRange.lowerBound
            return String(htmlString[range])
        }
        return nil
    }
    
    func convertStyleToDic(form styleString: String?) -> [String: String] {
        guard let styleString else { return [:] }
        var dic: [String: String] = [:]
        
        let lines = styleString.components(separatedBy: "\n")
        
        for line in lines {
            if let firstIndexKey = line.firstIndex(of: "."),
               let lastIndexKey = line.firstIndex(of: " "),
               let firstIndexValue = line.firstIndex(of: "{"),
               let lastIndexValue = line.firstIndex(of: "}") {
                
                var slicedKeyString = String(line[firstIndexKey..<lastIndexKey])
                slicedKeyString.removeFirst()
                
                var slicedValueString = String(line[firstIndexValue..<lastIndexValue])
                slicedValueString.removeFirst()
                
                dic[slicedKeyString] = slicedValueString
            }
        }
        return dic
    }
    
    func apply(style: [String: String], body: String) -> String? {
        var htmlBody = body
        
        for (key, value) in style {
            let ranges = htmlBody.ranges(of: "\"\(key)\"")
            if let lastRange = ranges.last?.upperBound {
                htmlBody.insert(contentsOf: " style=\"\(value)\"", at: lastRange)
            }
        }
        return htmlBody
    }
    
    func replaceImageTags(from htmlString: String, to replacements: [String]) -> String {
        var modifiedString = htmlString
        let regexPattern = "<img src=\"file[^>]*>"
        let regex = try! NSRegularExpression(pattern: regexPattern, options: [])

        var currentIndex = 0
        while let match = regex.firstMatch(
            in: modifiedString, options: [],
            range: NSRange(
                modifiedString.startIndex..., in: modifiedString
            )
        ), currentIndex < replacements.count {
            let replacementString = replacements[currentIndex]
            currentIndex += 1

            let replacementRange = match.range
            modifiedString = (modifiedString as NSString).replacingCharacters(in: replacementRange, with: replacementString) as String
        }

        return modifiedString
    }
}
