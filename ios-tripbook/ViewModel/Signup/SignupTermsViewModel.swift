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
        
        static func list() -> [Self] {
            return [.Service, .PersonalInfo, .Location, .Marketing]
        }
        
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
        
        func getDescription() -> URL? {
            switch self {
            case .Service: 
                return URL(string: "https://midnight-chips-141.notion.site/30cc27708b4f41f5abc3fb3b7014bcbf?pvs=4")
            case .PersonalInfo:
                return URL(string: "https://midnight-chips-141.notion.site/61234ba1e05d4dbd9705b2a6d4f615db?pvs=4")
            case .Location:
                return URL(string: "https://midnight-chips-141.notion.site/bc6070dd00a742e29f38eaa725967855?pvs=4")
            case .Marketing:
                return URL(string: "https://midnight-chips-141.notion.site/5ad532b146c04e5b8cac5cca5599b940?pvs=4")
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
        self.navigationTrigger = true
    }
}

extension SignupTermsViewModel: SignupTermDetailModalDelegate {
    func didTapHideModalButton() {
        self.isVisibleModal = false
    }
}
