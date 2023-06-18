//
//  SignupTermsView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI
import TBComponent
import TBUtil

protocol SignupTermsViewDelegate {
    func didTapAllAgreeCheckBox()
    func didTapAgreeCheckBox(_ type: SignupTermsViewModel.TermType)
    func didTapShowModalButton(_ type: SignupTermsViewModel.TermType)
    func didTapDoneButton()
}

struct SignupTermsView: View {
    @ObservedObject var signupViewModel: SignupViewModel
    @ObservedObject var viewModel = SignupTermsViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    init(_ signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                TBAppBar() {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                
                Text("서비스 이용 약관을 확인해주세요")
                    .font(TBFont.heading_1)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                
                Button(action: {
                    self.viewModel.didTapAllAgreeCheckBox()
                }) {
                    HStack(spacing: 12) {
                        TBCheckBox(self.viewModel.isAllAgreed())
                        
                        Text("전체동의")
                            .font(TBFont.title_2)
                            .foregroundColor(TBColor.grayscale.levels[8])
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(TBColor.grayscale.levels[1])
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
                
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(SignupTermsViewModel.TermType.allCases, id: \.rawValue) { type in
                        HStack {
                            Button(action: {
                                self.viewModel.didTapAgreeCheckBox(type)
                            }) {
                                HStack(spacing: 8) {
                                    TBCheckBox(Binding(get: {
                                        return self.viewModel.getIsAgreedTermByTermType(type)
                                    }, set: {_ in }))
                                    
                                    Text("(\(type.isRequired() ? "필수" : "선택")) \(type.getTitle())")
                                        .font(TBFont.body_2)
                                        .foregroundColor(TBColor.grayscale.levels[7])
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                self.viewModel.didTapShowModalButton(type)
                            }) {
                                TBIcon.next.iconSize(size: .small)
                            }.foregroundColor(TBColor.grayscale.levels[4])
                        }
                    }
                }.padding(.horizontal, 36)
                
                Spacer()
                
                TBPrimaryButton(
                    title: "다음으로 넘어가요",
                    isEnabled: self.viewModel.isValidTermsChecked()
                ) {
                    self.signupViewModel.registerUserTerms(self.viewModel.termList)
                    self.viewModel.didTapDoneButton()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
                NavigationLink(isActive: self.$viewModel.navigationTrigger, destination: {
                    SignupProfileNameView(self.signupViewModel)
                }, label: {
                    EmptyView()
                })
            }
            
            SignupTermDetailModal(
                self.viewModel.selectedModalType ?? SignupTermsViewModel.TermType.Service,
                delegate: self.viewModel
            )
            .opacity(self.viewModel.isVisibleModal ? 1 : 0)
        }.navigationBarHidden(true)
    }
}

struct SignupTermsView_Previews: PreviewProvider {
    static var previews: some View {
        SignupTermsView(SignupViewModel())
            .configureFont()
    }
}
