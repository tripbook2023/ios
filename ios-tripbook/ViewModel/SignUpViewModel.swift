//
//  SignUpViewModel.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/05/23.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    enum ViewTypeProperty {
        /// 약관동의 뷰
        case terms
        /// 닉네임 설정 뷰
        case nickname
        /// 프로필 이미지 설정 뷰
        case profileImage
    }
    
    let termList: [TermListModel] = [
        TermListModel(isRequired: true, termTitle: "서비스 이용약관 동의"),
        TermListModel(isRequired: true, termTitle: "개인정보 수집 및 이용 동의"),
        TermListModel(isRequired: true, termTitle: "위치정보 수집 및 이용 동의"),
        TermListModel(isRequired: false, termTitle: "마케팅 수신 동의")
    ]
    
    
    
    @Published var termChecked: [Bool] = [false, false, false, false]
    
    @Published var isRequiredAllChecked: Bool = false
    
    @Published var isAllChecked: Bool = false
    
    /// 뷰모델을 참조하는 뷰 타입
    var viewType: ViewTypeProperty
    /// 네비게이션바 타이틀
    var navigationTitle: String
    /// 닉네임 검증 에러 메세지
    @Published var stringVerifyNickname: String = ""
    
    
    init(viewType: ViewTypeProperty) {
        self.termChecked = [false, false, false, false, false]
        self.isRequiredAllChecked = false
        self.isAllChecked = false
        self.viewType = viewType
        self.stringVerifyNickname = ""
        
        /// viewType에 따른 네비게이션 타이틀 설정
        switch viewType {
        case .terms:
            self.navigationTitle = "서비스 이용 약관을 확인해주세요"
        case .nickname:
            self.navigationTitle = "멋진 여행 기록을 위해\n닉네임을 입력해주세요"
        case .profileImage:
            self.navigationTitle = "프로필 이미지를 등록해주세요"
        }
    }
    
    
    
    /// 약관 버튼 누를 시 이벤트
    /// desc: 약관 버튼을 누를시 필수 약관 비교 및 약관 선택 개수에 따른 선택여부 설정
    func termInfo(index: Int) {
        termChecked[index].toggle()
        
        self.checkRequiredTerms()
    }
    
    /// 필수약관 선택 여부 검증 및 전체 약관 선택 여부
    func checkRequiredTerms() -> Bool {
        let requiredTermsCount: Int = termList.filter({$0.isRequired == true}).count
        var checkedRequiredTermCount: Int = 0
        
        for i in 0...termList.count - 1 {
            if termList[i].isRequired {
                if termChecked[i] {
                    checkedRequiredTermCount += 1
                }
            }
        }
        
        return checkedRequiredTermCount == requiredTermsCount
//        isRequiredAllChecked = checkedRequiredTermCount == requiredTermsCount ? true : false
//        isAllChecked = checkedTermsCount >= termList.count ? true : false
    }
    
    /// 약관이 전부 동의 되었는지 검증
    func checkedAllTerms() -> Bool {
        let checkedTermsCount: Int = termChecked.filter({$0 == true}).count
        return checkedTermsCount >= termList.count ? true : false
    }
    
    /// 약관 전체 동의 버튼 이벤트
    func didTapAllTerms() {
        if isAllChecked {
            termChecked = [false, false, false, false]
        } else {
            termChecked = [true, true, true, true]
        }
        
        self.checkRequiredTerms()
    }
    
    /// 닉네임 로컬 검증
    /// Return: 오류메세지(String)
    func nicknameLocalVerify(text: String) {
        print("닉네임 로컬 검증")
        
        /// 닉네임 길이 검증
        if text.count > 10 {
            stringVerifyNickname = "10자 이내의 한글, 영어, 숫자를 입력해주세요"
            return
        }
        
        /// 문자열 검증
        let pattern = "^[가-힣A-Za-z0-9]{0,}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
            nicknameServerVerify(text: text)
        } else {
            stringVerifyNickname = "한글, 영어, 숫자를 입력해주세요"
        }
        
        
    }
    
    /// 닉네임 서버 검증
    /// Return: 오류메세지(String)
    func nicknameServerVerify(text: String) {
        /// 임시 하드코딩
        if text == "already" {
            stringVerifyNickname = "다른 분이 사용 중인 닉네임입니다"
        } else {
            stringVerifyNickname = ""
        }
    }
}

/// 뷰(레이아웃)과 관련된 함수 Extension
extension SignUpViewModel {
    /// 커스텀 네비게이션바
    func customNavigationBar(presentationMode: Binding<PresentationMode>) -> some View {
        return VStack(alignment: .leading) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
            }
            Text(navigationTitle)
                .padding(EdgeInsets(top: 57.47, leading: 0, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
