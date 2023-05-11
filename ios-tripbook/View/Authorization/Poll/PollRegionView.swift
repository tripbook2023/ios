//
//  PollRegionView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/25.
//
//  설문조사1(지역)

import SwiftUI

struct PollRegionView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 15)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                
                VStack(alignment: .leading, spacing: 10) {
                    PollProgressView(currentPage: 1)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    Text("주로 어떤 지역에 가세요?")
                        .font(.title2.bold())
                    
                    Text("최근 여행지로 입력해도 좋아요.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct PollRegionView_Previews: PreviewProvider {
    static var previews: some View {
        PollRegionView()
    }
}
