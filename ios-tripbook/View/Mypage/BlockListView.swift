//
//  BlockListView.swift
//  ios-tripbook
//
//  Created by 이시원 on 4/11/24.
//

import SwiftUI

struct BlockListView: View {
    @StateObject private var viewModel = BlockListViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 0) {
            TBAppBar(
                title: "차단 목록",
                onClickedBackButton: {
                     dismiss()
                }
            )
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(0..<viewModel.blockUsers.count, id: \.self) { i in
                        HStack {
                            TBAvatar(
                                type: .basic,
                                size: 34,
                                profileImageURL: viewModel.blockUsers[i].profileUrl
                            )
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(viewModel.blockUsers[i].name)
                                    .font(TBFont.body_4)
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            TBButton(
                                type: .filled,
                                size: .small,
                                title: "차단 해제",
                                isEnabled: .constant(true)
                            ) {
                                viewModel.requestDeleteBlock(index: i)
                            }
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(
                                    TBColor.grayscale._10,
                                    lineWidth: 1
                                )
                                .background(TBColor.grayscale._1)
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 32)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.requestBlockList()
        }
    }
}

#Preview {
    BlockListView()
}
