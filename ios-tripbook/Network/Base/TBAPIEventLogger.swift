//
//  TBAPIEventLogger.swift
//  ios-tripbook
//
//  Created by DDang on 6/25/23.
//

import Foundation
import Alamofire

class TBAPIEventLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.tripbookteam07.tripbook.networklogger")
    
    func requestDidFinish(_ request: Request) {
        print("⭐️ Request LOG")
        print(request.description)
        
        print("""
URL: \(request.request?.url?.absoluteString ?? "")
Method: \(request.request?.httpMethod ?? "")
Headers: \(request.request?.allHTTPHeaderFields ?? [:])
""")
        print("Authorization: \(request.request?.headers["Authorization"] ?? "")")
        print("Body: \(request.request?.httpBody?.toPrettyPrintedString ?? "")")
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("⭐️ Response LOG")
        print("""
URL: \(request.request?.url?.absoluteString ?? "")
Result: \(response.result)
StatusCode: \(response.response?.statusCode ?? 0)
Data: \(response.data?.toPrettyPrintedString ?? "")
""")
    }
}

extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString as String
    }
}
