//
//  NicknameTextState.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/23/23.
//

import Foundation

enum NicknameTextState {
    case None
    case Duplicate
    case Invalid
    case UseSpecialCharacters
    
    func getWarningMessage() -> String {
        switch self {
        case .None: return ""
        case .Duplicate: return "다른 분이 사용 중인 닉네임입니다"
        case .Invalid: return "10자 이내의 한글, 영어, 숫자를 입력해주세요"
        case .UseSpecialCharacters: return "한글, 영어, 숫자를 입력해주세요"
        }
    }
}
