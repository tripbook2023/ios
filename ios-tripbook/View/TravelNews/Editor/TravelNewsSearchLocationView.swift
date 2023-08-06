//
//  TravelNewsSearchLocationView.swift
//  ios-tripbook
//
//  Created by DDang on 8/6/23.
//

import SwiftUI

struct TravelNewsSearchLocationView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                TBIcon.search.iconSize(size: .small)
                
                TextField("여행지를 검색해주세요", text: .constant(""))
                    .font(TBFont.body_4)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        Text("제주도 제주시 한림읍")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                    }.padding(.vertical, 16)
                }
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .white.opacity(0), location: 0.00),
                                Gradient.Stop(color: .white, location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
            }
            
            TBPrimaryButton(title: "여행지 선택", isEnabled: .constant(false)) {
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 16)
        }
    }
}

#Preview {
    TravelNewsSearchLocationView()
}
