//
//  Bundle+Extension.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/12.
//

import Foundation

extension Bundle {
    var kakaoAPIKey : String {
        guard let file = self.path(forResource: "KakaoAPIInfo", ofType: "plist") else {
            fatalError("KakaoAPIInfo.plist 파일이 없습니다.")
        }
        let url = URL(fileURLWithPath: file)
        guard let resource = try? NSDictionary(contentsOf: url, error: ()) else {
            fatalError("KakaoAPIInfo.plist 파일 경로를 찾을 수 없습니다.")
        }
        guard let key = resource["API_KEY"] as? String else {
            fatalError("KakaoAPIInfo.plist 파일에 API_KEY를 입력해주세요.")
        }
        return key
    }
}
