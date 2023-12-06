//
//  TravelNewsMiniListView.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/6/23.
//

import SwiftUI

struct TravelNewsMiniListView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 11, alignment: .trailing),
                GridItem(.flexible(), spacing: 11, alignment: .leading)
            ], spacing: 11, content: {
                ForEach(0..<16, id: \.self) { _ in
                    TravelNewsEditorListItemView(item: TravelNewsModel.dummy)
                }
            }).padding(.vertical, 25)
        }
    }
}

#Preview {
    TravelNewsMiniListView()
}
