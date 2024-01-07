//
//  TravelNewsSearchLocationView.swift
//  ios-tripbook
//
//  Created by DDang on 8/6/23.
//

import SwiftUI

struct TravelNewsSearchLocationView: View {
    @StateObject private var viewModel = TravelNewsSearchLocationViewModel()
    @ObservedObject private var registerViewModel: RegisterTravelNewsViewModel
    @Environment(\.dismiss) private var dismiss
    init(registerViewModel: RegisterTravelNewsViewModel) {
        self.registerViewModel = registerViewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TBSearchBar($viewModel.searchKeyword, placeholder: "여행지를 검색해주세요")
            .padding(.vertical, 16)

            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    List(0..<viewModel.locationInfos.count, id: \.self, selection: $viewModel.selectionIndex) { i in
                        Text(viewModel.locationInfos[i].placeName)
                            .listRowBackground(viewModel.selectionIndex == i ? TBColor.primary._1 : Color.clear)
                            .font(TBFont.body_4)
                            .foregroundColor(TBColor.grayscale._80)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                    }
                    .listStyle(.plain)
                    .opacity(viewModel.locationInfos.isEmpty ? 0 : 1)
                    
                    Text("원하시는 검색 결과를 찾을 수 없습니다.")
                        .font(TBFont.body_4)
                        .padding(.bottom, geometry.size.height * 0.8)
                        .opacity(viewModel.locationInfos.isEmpty ? 1 : 0)
                    
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
            }
            
            TBPrimaryButton(title: "여행지 선택", isEnabled: .constant(viewModel.selectionIndex != nil)) {
                if let selectedIndex = viewModel.selectionIndex {
                    registerViewModel.location = viewModel.locationInfos[selectedIndex]
                }
                dismiss()
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 16)
        }
    }
}

struct TravelNewsSearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsSearchLocationView(registerViewModel: .init())
    }
}
