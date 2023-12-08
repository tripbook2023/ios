//
//  TravelNewsMiniListView.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/6/23.
//

import SwiftUI

struct TravelNewsMiniListView: View {
    @Binding private var items: [TravelNewsModel]
    
    init(items: Binding<[TravelNewsModel]>) {
        self._items = items
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 11, alignment: .trailing),
                GridItem(.flexible(), spacing: 11, alignment: .leading)
            ], spacing: 11, content: {
                ForEach(0..<items.count, id: \.self) { i in
                    let item = items[i]
                    TravelNewsMiniListItemView(
                        item: item
                    )
                }
            }).padding(.vertical, 25)
        }
    }
}

#Preview {
    TravelNewsMiniListView(items: .constant([
        TravelNewsModel.dummy,
        TravelNewsModel.dummy,
        TravelNewsModel.dummy,
        TravelNewsModel.dummy
    ]))
}
