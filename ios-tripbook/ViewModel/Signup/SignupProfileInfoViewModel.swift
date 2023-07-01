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
            
            return dateFormatter.date(from: "\(year ?? String(1930))-\(month ?? String(1))-\((Int(day ?? String(1)) ?? 1) + 1)") ?? Date()
        }
    }
    
    @Published var gender: RegisterationUser.Gender? = nil
    @Published var birth = SignupBirthInput()
    
    @Published var showBirthYearPicker: Bool = false
    @Published var showBirthMonthPicker: Bool = false
    @Published var showBirthDayPicker: Bool = false
    
    let years: [String] = (1930...Calendar.current.component(.year, from: Date())).reversed().map({ String($0) })
    let months: [String] = (1...12).map({ String(format: "%02d", $0) })
    func days() -> Binding<[String]> {
        return Binding(get: {
            var dateComponents = DateComponents()
            dateComponents.year = Int(self.birth.year ?? String(Calendar.current.component(.year, from: Date())))
            dateComponents.month = Int(self.birth.month ?? String(1))
            
            if let d = Calendar.current.date(from: dateComponents),
               let interval = Calendar.current.dateInterval(of: .month, for: d),
               let days = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day {
                return (1...days).map({ String(format: "%02d", $0) })
            } else { return [] }
        }, set: {_ in})
    }
    
    func birthWarningMessages() -> Binding<String> {
        return Binding(get: {
            var array: [String] = []
            
            if self.birth.year == nil {
                array.append("연도")
            }
            if self.birth.month == nil {
                array.append("월")
            }
            if self.birth.day == nil {
                array.append("일")
            }
            
            return "생일 \(array.joined(separator: "/"))을 입력해주세요"
        }, set: {_ in})
    }
}

extension SignupProfileInfoViewModel: SignupProfileInfoViewDelegate {
    func didTapGenderButton(_ gender: RegisterationUser.Gender) {
        self.gender = gender
    }
    
    func didTapYearPickerButton() {
        self.showBirthYearPicker.toggle()
    }
    
    func didTapMonthPickerButton() {
        self.showBirthMonthPicker.toggle()
    }
    
    func didTapDayPickerButton() {
        self.showBirthDayPicker.toggle()
    }
    
    func didTapYearButton(_ year: String) {
        self.birth.year = year
        self.showBirthYearPicker = false
        
        print(self.birth.toDomain)
    }
    
    func didTapMonthButton(_ month: String) {
        self.birth.month = month
        self.showBirthMonthPicker = false
        
        print(self.birth.toDomain)
    }
    
    func didTapDayButton(_ day: String) {
        self.birth.day = day
        self.showBirthDayPicker = false
        
        print(self.birth.toDomain)
    }
    
    func didDoneButton() {
        
    }
}
