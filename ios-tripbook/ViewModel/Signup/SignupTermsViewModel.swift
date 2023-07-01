//
//  SignupTermsViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/15.
//

import Foundation
import SwiftUI

class SignupTermsViewModel: ObservableObject {
    enum TermType: String, CaseIterable {
        case Service        = "termsOfService"
        case PersonalInfo   = "termsOfPrivacy"
        case Location       = "termsOfLocation"
        case Marketing      = "marketingConsent"
        
        func isRequired() -> Bool {
            switch self {
            case .Service:      return true
            case .PersonalInfo: return true
            case .Location:     return true
            case .Marketing:    return false
            }
        }
        
        func getTitle() -> String {
            switch self {
            case .Service:      return "서비스 이용약관 동의"
            case .PersonalInfo: return "개인정보 수집 및 이용 동의"
            case .Location:     return "위치정보수집 및 이용동의"
            case .Marketing:    return "마케팅 수신 동의"
            }
        }
        
        func getDescription() -> String {
            switch self {
            default:
                return """
                트립북 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 트립북 서비스를 제공하는 트립북과 이를 이용하는 트립북 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 트립북 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
                
                트립북 서비스를 이용하시거나 트립북 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.
                
                다양한 트립북 서비스를 즐겨보세요.
                트립북은 www.tripbook.co.kr을 비롯한 트립북 도메인의 웹사이트 및 응용프로그램(어플리케이션, 앱)을 통해 정보 검색, 다른 이용자와의 커뮤니케이션, 콘텐츠 제공, 상품 쇼핑 등 여러분의 네이버 회원가입 방법 등에서 확인해 주세요.
                """
            }
        }
    }
    
    @Published var termList: [String:Bool] = [
        TermType.Service.rawValue       : false,
        TermType.PersonalInfo.rawValue  : false,
        TermType.Location.rawValue      : false,
        TermType.Marketing.rawValue     : false
    ]
    @Published var selectedModalType: TermType? = nil
    
    @Published var isVisibleModal: Bool = false
    @Published var navigationTrigger: Bool = false
    
    func getIsAgreedTermByTermType(_ type: TermType) -> Bool {
        return self.termList[type.rawValue] ?? false
    }
    
    func isAllAgreed() -> Binding<Bool> {
        return Binding(get: {
            return self.termList.count == self.termList.values.filter({ value in value == true }).count
        }, set: {_ in})
    }
    
    func isValidTermsChecked() -> Binding<Bool> {
        return Binding(get: {
            let requiredTermList = TermType.allCases.filter({ $0.isRequired() })
            
            return requiredTermList.count == requiredTermList.map({ self.getIsAgreedTermByTermType($0) }).filter({ $0 }).count
        }, set: {_ in})
    }
}

extension SignupTermsViewModel: SignupTermsViewDelegate {
    func didTapAllAgreeCheckBox() {
        self.termList = self.termList.mapValues { _ in self.termList.values.contains(false) }
    }
    
    func didTapAgreeCheckBox(_ type: TermType) {
        self.termList[type.rawValue]?.toggle()
    }
    
    func didTapShowModalButton(_ type: TermType) {
        self.selectedModalType = type
        self.isVisibleModal = true
    }
    
    func didTapDoneButton() {
        self.navigationTrigger.toggle()
    }
}

extension SignupTermsViewModel: SignupTermDetailModalDelegate {
    func didTapHideModalButton() {
        self.isVisibleModal = false
    }
}
