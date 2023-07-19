//
//  SignupProfileInfoViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/18.
//

import Foundation
import SwiftUI

class SignupProfileInfoViewModel: ObservableObject {
    struct SignupBirthInput {
        var year: String?
        var month: String?
        var day: String?
        
        var toDomain: Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            return dateFormatter.date(from: "\(year ?? String(1930))-\(month ?? String(1))-\(Int(day ?? String(1)) ?? 1)") ?? Date()
        }
    }
    
    let startDate = Calendar.current.date(from: {
        var dateComponents = DateComponents()
        
        dateComponents.year = 1930
        dateComponents.month = 1
        dateComponents.day = 1
        
        return dateComponents
    }())!
    let endDate: Date = .now
    
    @Published var isShowBirthModal: Bool = false
    @Published var navigationTrigger: Bool = false
    
    @Published var gender: Gender? = nil
    @Published var birth: Date?
    var birthText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy - MM - dd"
        
        return dateFormatter.string(from: self.birth ?? .now)
    }
}

extension SignupProfileInfoViewModel: SignupProfileInfoViewDelegate {
    func didTapGenderButton(_ gender: Gender) {
        self.gender = gender
    }
    
    func didTapBirthButton() {
        self.isShowBirthModal = true
    }
    
    func didTapDoneButton() {
        self.navigationTrigger = true
    }
}
