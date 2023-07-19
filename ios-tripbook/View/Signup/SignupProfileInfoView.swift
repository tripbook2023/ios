//
//  SignupProfileInfoView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI

protocol SignupProfileInfoViewDelegate {
    func didTapGenderButton(_ gender: Gender)
    func didTapBirthButton()
    func didTapDoneButton()
}

struct SignupProfileInfoView: View {
    @ObservedObject var signupViewModel: SignupViewModel
    @ObservedObject var viewModel = SignupProfileInfoViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedDate: Date = .now
    
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
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Button(action: {
                            self.viewModel.didTapBirthButton()
                        }) {
                            HStack {
                                Text(self.viewModel.birth == nil ? "YYYY - MM - DD" : self.viewModel.birthText)
                                    .font(TBFont.body_4)
                                    .foregroundColor(self.viewModel.birth == nil ? TBColor.grayscale.levels[2] : TBColor.grayscale.levels[9])
                                
                                Spacer()
                                
                                // TODO: - Calendar Icon
                            }
                        }
                        .padding(.top, 10)
                        .padding(.vertical, 14)
                        
                        Divider()
                            .frame(minHeight: 1)
                            .overlay(
                                self.viewModel.birth == nil ? TBColor.grayscale.levels[1] : TBColor.grayscale.levels[8]
                            )
                    }
                }
            }
            
            Spacer()
            
            TBPrimaryButton(
                title: "입력완료",
                isEnabled: Binding(get: {
                    return self.viewModel.gender != nil && self.viewModel.birth != nil
                }, set: {_ in})
            ) {
                self.signupViewModel.registerUserGender(self.viewModel.gender!)
                self.signupViewModel.registerUserBirth(self.viewModel.birth!)
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
        .overlay(self.birthModal)
    }
    
    @ViewBuilder
    var birthModal: some View {
        if self.viewModel.isShowBirthModal {
            ZStack {
                Color.black.opacity(0.6)
                
                VStack(spacing: 24) {
                    DatePicker("", selection: self.$selectedDate, in: ...(.now), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .tint(TBColor.primary.main)
                    
                    HStack(spacing: 8) {
                        Button(action: {
                            self.viewModel.isShowBirthModal = false
                        }) {
                            Text("닫기")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .font(.suit(.medium, size: 14))
                                .foregroundColor(TBColor.grayscale.levels[5])
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(TBColor.grayscale.levels[1])
                                )
                        }
                        
                        Button(action: {
                            print(self.selectedDate)
                            self.viewModel.isShowBirthModal = false
                            self.viewModel.birth = self.selectedDate
                        }) {
                            Text("선택")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .font(.suit(.medium, size: 14))
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(TBColor.primary.main)
                                )
                        }
                    }
                }
                .frame(maxWidth: 300)
                .padding(.all, 20)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .ignoresSafeArea()
        } else {
            ZStack {
                Color.clear
            }
            .ignoresSafeArea()
        }
    }
}

struct SignupProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SignupProfileInfoView(SignupViewModel())
    }
}
