//
//  TermsDetailView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/05/25.
//

import SwiftUI

struct TermsDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var viewModel: SignUpViewModel = SignUpViewModel(viewType: .terms)
    
    var index: Int
    
    var body: some View {
        ZStack {
            Color(.black).opacity(0.6)
            VStack {
                Spacer()
                ZStack {
                    VStack {
                        Text(viewModel.termList[index].termTitle)
                            .padding(EdgeInsets(top: 24, leading: 16, bottom:18, trailing: 16))
                        ScrollView {
                            Text("서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의 동의서비스 이용약관 동의")
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 18, trailing: 16))
                                .frame(alignment: .top)
                        }
                        .frame(maxHeight: 364)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                }
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                .frame(height: 442)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 12, trailing: 20))
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "xmark")
                        Text("닫기")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 38)
                    .background(RoundedRectangle(cornerRadius: 19)
                        .foregroundColor(.black))
                })
                .foregroundColor(.white)
                .frame(height: 38)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 48, trailing: 20))
                
            }
        }
        .ignoresSafeArea()
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return InnerView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    private class InnerView: UIView {
        override func didMoveToWindow() {
            super.didMoveToWindow()
            
            superview?.superview?.backgroundColor = .clear
        }
        
    }
}

struct TermsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TermsDetailView(index: 0)
    }
}
