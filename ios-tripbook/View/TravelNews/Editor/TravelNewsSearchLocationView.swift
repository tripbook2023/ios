//
//  TravelNewsSearchLocationView.swift
//  ios-tripbook
//
//  Created by DDang on 8/6/23.
//

import SwiftUI

struct TravelNewsSearchLocationView: View {
    @ObservedObject var viewModel = TravelNewsSearchLocationViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                TBIcon.search.iconSize(size: .small)
                
                TextField("여행지를 검색해주세요", text: $viewModel.searchKeyword)
                    .font(TBFont.body_4)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            Divider()
                .background(TBColor.grayscale._5)
                .padding(.bottom, 18)
            ZStack(alignment: .bottom) {
                List(0..<viewModel.locationInfos.count, id: \.self, selection: $viewModel.selectionIndex) { i in
                    Text(viewModel.locationInfos[i].placeName)
                        .listRowBackground(viewModel.selectionIndex == i ? TBColor.primary._1 : Color.clear)
                        .font(TBFont.body_4)
                        .foregroundColor(TBColor.grayscale._80)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                }.listStyle(.plain)
                
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

struct TravelNewsSearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsSearchLocationView()
    }
}
