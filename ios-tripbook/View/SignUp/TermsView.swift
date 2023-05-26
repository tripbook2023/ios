//
//  TermsView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/05/22.
//

import SwiftUI

struct TermsView: View, BottomButtonDelegate {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = SignUpViewModel(viewType: .terms)
    @State var isNavigationLink: Bool = false
    
    
    /// 바텀버튼의 델리게이트 채택 및 함수 구현
    func didTapBottomButton() {
        print("바텀버튼 클릭")
        if viewModel.checkRequiredTerms() {
            print("필수약관 체크 됨")
            isNavigationLink = true
        }
    }
    
    var buttonTitle: String? = "다음으로 넘어가요"
    
    var buttonHeight: CGFloat?
    
    //MARK: - 약관동의 뷰
    var body: some View {
        NavigationView {
            VStack {
                /// 커스텀 네비게이션바
                viewModel.customNavigationBar(presentationMode: presentationMode)
                
                /// 전체 이용 약관 동의
                HStack {
                    Button(action: { viewModel.didTapAllTerms() },
                           label: {
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(viewModel.checkedAllTerms() ? .orange : .gray)
                            .frame(width: 24)
                        Text("전체동의")
                            .foregroundColor(.black)
                    })
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                }
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray.opacity(0.3))
                )
                .padding(EdgeInsets(top: 40, leading: 0, bottom: 32, trailing: 0))
                
                ForEach(0...viewModel.termList.count - 1, id: \.self) { index in
                    TermListView(viewModel: viewModel, index: index)
                }
                
                Spacer()
                
                /// 바텀버튼
                NavigationLink(destination: NicknameSettingView(), isActive: $isNavigationLink) {}
                BottomButton(delegate: self, buttonEnabled: viewModel.checkRequiredTerms())
                
                
            }
            
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true)
        }
    }
}

//MARK: - 약관 리스트 뷰
struct TermListView: View {
    @ObservedObject var viewModel: SignUpViewModel
    @State var isShowModal = false
    
    /// 약관 정보
    var index: Int
    
    var body: some View {
        /// 전체 이용 약관 동의
        HStack {
            Button(action: {
                viewModel.termInfo(index: index)
            }, label: {
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(viewModel.termChecked[index] ? .orange : .gray)
                    .frame(width: 24)
                Text("\(viewModel.termList[index].isRequired ? "(필수)" : "(선택)") \(viewModel.termList[index].termTitle)")
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    self.isShowModal = true
                }, label: {
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                        .frame(width: 8)
                })
                .fullScreenCover(isPresented: self.$isShowModal) {
                    TermsDetailView(index: index)
                    
                    .background(BackgroundBlurView())
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
