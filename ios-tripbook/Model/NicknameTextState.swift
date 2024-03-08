//
//  NicknameTextState.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/23/23.
//

import Foundation

enum NicknameTextState {
    case none
    case duplicate
    case invalid
    case useSpecialCharacters
    case notSame
    
    func getWarningMessage() -> String {
        switch self {
        case .none: return ""
        case .duplicate: return "다른 분이 사용 중인 닉네임입니다"
        case .invalid: return "10자 이내의 한글, 영어, 숫자를 입력해주세요"
        case .useSpecialCharacters: return "한글, 영어, 숫자를 입력해주세요"
        case .notSame: return "닉네임이 동일하지 않습니다."
        }
    }
}
