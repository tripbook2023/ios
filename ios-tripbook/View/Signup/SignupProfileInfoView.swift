//
//  SignupProfileInfoView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI
import TBComponent
import TBUtil

protocol SignupProfileInfoViewDelegate {
    func didTapGenderButton(_ gender: SignupProfileInfoViewModel.Gender)
    func didDoneButton()
}

struct SignupProfileInfoView: View {
    @ObservedObject var signupViewModel: SignupViewModel
    @ObservedObject var viewModel = SignupProfileInfoViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    init(_ signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TBAppBar() {
                self.presentationMode.wrappedValue.dismiss()
            }.padding(.bottom, 40)
            
            Text("조금 더 알아볼게요")
                .font(TBFont.heading_1)
                .foregroundColor(TBColor.grayscale.levels[9])
                .padding(.bottom, 56)
            
            VStack(alignment: .leading, spacing: 25) {
                Text("성별을 선택해주세요")
                    .font(TBFont.body_1)
                    .foregroundColor(TBColor.grayscale.levels[8])
                
                HStack(spacing: 7) {
                    Button(action: {
                        self.viewModel.didTapGenderButton(.Female)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(
                                    self.viewModel.gender == .Female ? TBColor.primary.main : TBColor.grayscale.levels[3],
                                    lineWidth: self.viewModel.gender == .Female ? 2 : 1
                                )
                                .frame(height: 48)
                            
                            Text("여성")
                                .font(self.viewModel.gender == .Female ? TBFont.title_3 : TBFont.body_3)
                                .foregroundColor(self.viewModel.gender == .Female ? TBColor.primary.main : TBColor.grayscale.levels[3])
                        }
                    }
                    
                    Button(action: {
                        self.viewModel.didTapGenderButton(.Male)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(
                                    self.viewModel.gender == .Male ? TBColor.primary.main : TBColor.grayscale.levels[3],
                                    lineWidth: self.viewModel.gender == .Male ? 2 : 1
                                )
                                .frame(height: 48)
                            
                            Text("남성")
                                .font(self.viewModel.gender == .Male ? TBFont.title_3 : TBFont.body_3)
                                .foregroundColor(self.viewModel.gender == .Male ? TBColor.primary.main : TBColor.grayscale.levels[3])
                        }
                    }
                }.padding(.bottom, 48)
            }.padding(.bottom, 48)
            
            if self.viewModel.gender != nil {
                VStack(alignment: .leading, spacing: 11) {
                    Text("연령대를 선택해주세요")
                        .font(TBFont.body_1)
                        .foregroundColor(TBColor.grayscale.levels[8])
                    
                    TBTextField(
                        title: "나이 입력",
                        text: self.$viewModel.ageText,
                        isValid: self.viewModel.isValidAge(),
                        warningMessage: .constant("10-100 사이의 숫자를 입력주세요")
                    ) {
                        
                    }.keyboardType(.numberPad)
                }
            }
            
            Spacer()
            
            TBPrimaryButton(
                title: "입력완료",
                isEnabled: .constant(false)
            ) {
                
            }
        }.padding(.horizontal, 20)
    }
}

struct SignupProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SignupProfileInfoView(SignupViewModel())
            .configureFont()
    }
}
