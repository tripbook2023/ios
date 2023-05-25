//
//  SignUpNavigationBar.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/05/22.
//

import SwiftUI

/// 회원가입 네비게이션바 델리게이트(프로토콜)
protocol SignUpNavigationBarDelegate {
    /// 네비게이션바 뒤로가기 버튼 클릭 이벤트
    func didTapBackButton()
    /// 네비게이션바 타이틀 텍스트 설정
    var navigationTitle: String { get set }
}

struct SignUpNavigationBar: View {
    var delegate: SignUpNavigationBarDelegate?
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {delegate?.didTapBackButton()}) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
            }
            Text(delegate?.navigationTitle ?? "Label")
                .padding(EdgeInsets(top: 57.47, leading: 0, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SignUpNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNavigationBar()
    }
}
