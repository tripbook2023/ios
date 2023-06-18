//
//  SignupProfileInfoViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/18.
//

import Foundation
import SwiftUI

class SignupProfileInfoViewModel: ObservableObject {
    @Published var gender: RegisterationUser.Gender? = nil
    @Published var ageText: String = ""
    
    func isValidAge() -> Binding<Bool?> {
        return Binding(get: {
            if let age = Int(self.ageText) {
                if age >= 10 && age <= 100 {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }, set: {_ in})
    }
}

extension SignupProfileInfoViewModel: SignupProfileInfoViewDelegate {
    func didTapGenderButton(_ gender: RegisterationUser.Gender) {
        self.gender = gender
    }
    
    func didDoneButton() {
        
    }
}
