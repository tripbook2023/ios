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
    func didTapGenderButton(_ gender: RegisterationUser.Gender)
    
    func didTapYearPickerButton()
    func didTapMonthPickerButton()
    func didTapDayPickerButton()
    func didTapYearButton(_ year: String)
    func didTapMonthButton(_ month: String)
    func didTapDayButton(_ day: String)
    
    func didTapDoneButton()
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
            
            VStack(alignment: .leading, spacing: 24) {
                Text("성별을 선택해주세요")
                    .font(TBFont.body_2)
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
                                .font(self.viewModel.gender == .Female ? TBFont.title_3 : TBFont.body_4)
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
                                .font(self.viewModel.gender == .Male ? TBFont.title_3 : TBFont.body_4)
                                .foregroundColor(self.viewModel.gender == .Male ? TBColor.primary.main : TBColor.grayscale.levels[3])
                        }
                    }
                }
            }.padding(.bottom, 48)
            
            if self.viewModel.gender != nil {
                VStack(alignment: .leading, spacing: 0) {
                    Text("생일을 선택해주세요")
                        .font(TBFont.body_2)
                        .foregroundColor(TBColor.grayscale.levels[8])
                    
                    HStack(spacing: 4) {
                        Button(action: {
                            self.viewModel.didTapYearPickerButton()
                        }) {
                            HStack {
                                Text(self.viewModel.birth.year ?? "YYYY")
                                    .font(self.viewModel.birth.year != nil ? TBFont.title_3 : TBFont.body_4)
                                    .foregroundColor(self.viewModel.birth.year != nil ? Color(red: 0.11, green: 0.09, blue: 0.09) : Color(red: 0.78, green: 0.75, blue: 0.74))
                                
                                Spacer()
                                
                                if self.viewModel.showBirthYearPicker {
                                    TBIcon.up.iconSize(size: .small)
                                        .foregroundColor(Color(red: 0.11, green: 0.09, blue: 0.09))
                                } else {
                                    TBIcon.down[0].iconSize(size: .small)
                                        .foregroundColor(Color(red: 0.78, green: 0.75, blue: 0.74))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .padding(.leading, 16)
                        .padding(.trailing, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(self.viewModel.showBirthYearPicker ? Color(red: 0.11, green: 0.09, blue: 0.09) : Color(red: 0.78, green: 0.75, blue: 0.74), lineWidth: 1)
                        )
                        
                        Button(action: {
                            self.viewModel.didTapMonthPickerButton()
                        }) {
                            HStack {
                                Text(self.viewModel.birth.month ?? "MM")
                                    .font(self.viewModel.birth.year != nil ? TBFont.title_3 : TBFont.body_4)
                                    .foregroundColor(self.viewModel.birth.month != nil ? Color(red: 0.11, green: 0.09, blue: 0.09) : Color(red: 0.78, green: 0.75, blue: 0.74))
                                
                                Spacer()
                                
                                if self.viewModel.showBirthMonthPicker {
                                    TBIcon.up.iconSize(size: .small)
                                        .foregroundColor(Color(red: 0.11, green: 0.09, blue: 0.09))
                                } else {
                                    TBIcon.down[0].iconSize(size: .small)
                                        .foregroundColor(Color(red: 0.78, green: 0.75, blue: 0.74))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .padding(.leading, 16)
                        .padding(.trailing, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(self.viewModel.showBirthMonthPicker ? Color(red: 0.11, green: 0.09, blue: 0.09) : Color(red: 0.78, green: 0.75, blue: 0.74), lineWidth: 1)
                        )
                        
                        Button(action: {
                            self.viewModel.didTapDayPickerButton()
                        }) {
                            HStack {
                                Text(self.viewModel.birth.day ?? "DD")
                                    .font(self.viewModel.birth.year != nil ? TBFont.title_3 : TBFont.body_4)
                                    .foregroundColor(self.viewModel.birth.day != nil ? Color(red: 0.11, green: 0.09, blue: 0.09) : Color(red: 0.78, green: 0.75, blue: 0.74))
                                
                                Spacer()
                                
                                if self.viewModel.showBirthDayPicker {
                                    TBIcon.up.iconSize(size: .small)
                                        .foregroundColor(Color(red: 0.11, green: 0.09, blue: 0.09))
                                } else {
                                    TBIcon.down[0].iconSize(size: .small)
                                        .foregroundColor(Color(red: 0.78, green: 0.75, blue: 0.74))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .padding(.leading, 16)
                        .padding(.trailing, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(self.viewModel.showBirthDayPicker ? Color(red: 0.11, green: 0.09, blue: 0.09) : Color(red: 0.78, green: 0.75, blue: 0.74), lineWidth: 1)
                        )
                    }.padding(.top, 11)
                    
                    ZStack(alignment: .topLeading) {
                        if self.viewModel.birth.year == nil || self.viewModel.birth.month == nil || self.viewModel.birth.day == nil {
                            HStack(spacing: 4) {
                                Image(systemName: "exclamationmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(TBColor.state.warning)
                                
                                Text(self.viewModel.birthWarningMessages().wrappedValue)
                                    .font(TBFont.caption_1)
                                    .foregroundColor(TBColor.state.warning)
                            }.padding(.top, 8)
                        }
                        
                        HStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.11, green: 0.09, blue: 0.09), lineWidth: 1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 170)
                                .background(.white)
                                .overlay(
                                    ScrollView {
                                        VStack(spacing: 0) {
                                            ForEach(self.viewModel.years, id: \.self) { year in
                                                Button(action: {
                                                    self.viewModel.didTapYearButton(year)
                                                }) {
                                                    HStack {
                                                        Text(year)
                                                        Spacer()
                                                    }
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 36)
                                                    .padding(.horizontal, 16)
                                                    .font(.suit(.medium, size: 14))
                                                    .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.05))
                                                    .background(self.viewModel.birth.year == year ? Color(red: 1, green: 0.97, blue: 0.95) : .clear)
                                                }
                                            }
                                        }
                                    }.padding(1.5)
                                ).opacity(self.viewModel.showBirthYearPicker ? 1 : 0)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.11, green: 0.09, blue: 0.09), lineWidth: 1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 170)
                                .background(.white)
                                .overlay(
                                    ScrollView {
                                        VStack(spacing: 0) {
                                            ForEach(self.viewModel.months, id: \.self) { month in
                                                Button(action: {
                                                    self.viewModel.didTapMonthButton(month)
                                                }) {
                                                    HStack {
                                                        Text(month)
                                                        Spacer()
                                                    }
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 36)
                                                    .padding(.horizontal, 16)
                                                    .font(.suit(.medium, size: 14))
                                                    .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.05))
                                                    .background(self.viewModel.birth.month == month ? Color(red: 1, green: 0.97, blue: 0.95) : .clear)
                                                }
                                            }
                                        }
                                    }.padding(1.5)
                                ).opacity(self.viewModel.showBirthMonthPicker ? 1 : 0)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.11, green: 0.09, blue: 0.09), lineWidth: 1)
                                .frame(maxWidth: .infinity)
                                .frame(height: 170)
                                .background(.white)
                                .overlay(
                                    ScrollView {
                                        VStack(spacing: 0) {
                                            ForEach(self.viewModel.days().wrappedValue, id: \.self) { day in
                                                Button(action: {
                                                    self.viewModel.didTapDayButton(day)
                                                }) {
                                                    HStack {
                                                        Text(day)
                                                        Spacer()
                                                    }
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 36)
                                                    .padding(.horizontal, 16)
                                                    .font(.suit(.medium, size: 14))
                                                    .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.05))
                                                    .background(self.viewModel.birth.day == day ? Color(red: 1, green: 0.97, blue: 0.95) : .clear)
                                                }
                                            }
                                        }
                                    }.padding(1.5)
                                ).opacity(self.viewModel.showBirthDayPicker ? 1 : 0)
                        }.padding(.top, 4)
                    }
                }
            }
            
            Spacer()
            
            TBPrimaryButton(
                title: "입력완료",
                isEnabled: Binding(get: {
                    return self.viewModel.gender != nil && (self.viewModel.birth.toDomain != Date())
                }, set: {_ in})
            ) {
                self.signupViewModel.registerUserGender(self.viewModel.gender!)
                self.signupViewModel.registerUserBirth(self.viewModel.birth.toDomain)
                self.signupViewModel.registerUser() {
                    self.viewModel.didTapDoneButton()
                }
            }
            
            NavigationLink(
                isActive: self.$viewModel.navigationTrigger,
                destination: {
                    SignupCompletionView()
                }, label: {
                    EmptyView()
                }
            )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
        .navigationBarHidden(true)
    }
}

struct SignupProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SignupProfileInfoView(SignupViewModel())
            .configureFont()
    }
}
