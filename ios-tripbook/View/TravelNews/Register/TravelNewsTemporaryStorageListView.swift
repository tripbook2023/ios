//
//  TravelNewsTemporaryStorageListView.swift
//  ios-tripbook
//
//  Created by DDang on 8/6/23.
//

import SwiftUI

struct TravelNewsTemporaryStorageListView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: RegisterTravelNewsViewModel
    @State private var selectedIndex: Int? = nil
    
    init(viewModel: RegisterTravelNewsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        TBIcon.cancel.iconSize(size: .medium)
                    }.foregroundColor(TBColor.grayscale._90)
                }
                
                Text("임시저장 목록")
                    .font(TBFont.body_3)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(0..<viewModel.tempItems.count, id: \.self) { index in
                        Button {
                             selectedIndex = index
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("제목입니다")
                                        .font(TBFont.body_4)
                                        .foregroundColor(.black)
                                    
                                    Text("23.10.10")
                                        .font(TBFont.caption_2)
                                        .foregroundColor(TBColor.grayscale._30)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    print("\(index) 삭제")
                                }) {
                                    TBIcon.cancel.iconSize(size: .small)
                                }.foregroundColor(TBColor.grayscale._70)
                            }
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(
                                    selectedIndex == index ? TBColor.primary._50 : TBColor.grayscale._10,
                                    lineWidth: 1
                                )
                                .background(
                                    selectedIndex == index ? TBColor.primary._1 : TBColor.grayscale._1
                                )
                            )

                        }
                    }
                    

                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 32)
            }
            
            TBPrimaryButton(title: "선택 완료", isEnabled: .constant(false)) {
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
        }
        .onAppear {
            viewModel.fatchTempList()
        }
    }
}

struct TravelNewsTemporaryStorageListView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsTemporaryStorageListView(viewModel: .init())
    }
}
