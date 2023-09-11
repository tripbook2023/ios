//
//  RequestEditorViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/21.
//

import Foundation

/// 여행소식 에디터 신청 View Model
/// - Author: 김민규
/// - Date: 2023/05/21
class RequestEditorViewModel: ObservableObject {
    /// 에디터 신청 상태
    enum ReviewStatus {
        /// 신청 전
        case before
        
        /// 심사 중
        case inProgress
        
        /// 심사 완료
        case complete
    }
    
    let dataStorage = DataStorage.shared
    
    /// 에디터 신청 상태
    @Published var status: ReviewStatus = .complete
    
    /// 에디터 신청 이메일 입력 텍스트
    @Published var emailTextField: String = ""
    
    @Published var errorMessage: String = ""
    @Published var time = 60 * 10
    @Published var isHidden: Bool = true
    @Published var isTimer: Bool = false
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}