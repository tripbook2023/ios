//
//  TermsView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/25.
//
//  회원가입1(약관 동의)

import SwiftUI

struct TermsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Label {
                Text("전체동의")
                    .font(.system(size: 17))
            } icon: {
                Image(systemName: "checkmark.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
            }
            
            TermListView(termType: 1)
            
            TermListView(termType: 2)
            
            TermListView(termType: 3)
            
            Spacer()
            
        }
        .padding()
        .frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
    }
}

struct TermListView: View {
    /// 약관 타입 1: 서비스 이용약관, 2: 개인정보 수집동의, 3: 마케팅 수신 동의
    @State var termType: Int = 1
    @State var termText: [String] = [
        "(필수) 서비스 이용약관 동의",
        "(필수) 개인정보 수집 및 이용 동의",
        "(선택) 마케팅 수신 동의"]
    @State var checked: Bool = false
    
    var body: some View {
        HStack {
            Label {
                Text(termText[termType - 1])
            } icon: {
                Image(systemName: checked ? "checkmark.square.fill" : "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                    .onTapGesture {
                        checkTerm()
                    }
            }
            
            Spacer()
            Button("보기", action: {})
                .frame(width: 80)
        }
        .frame(height: 30)
    }
}

extension TermListView {
    /**
     약관 확인
     > 약관의 확인 여부를 토그
     */
    func checkTerm() {
        checked.toggle()
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
