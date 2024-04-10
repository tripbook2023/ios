//
//  TravelNewsMiniListView.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/6/23.
//

import SwiftUI

struct TravelNewsMiniListView: View {
    @Binding private var items: [TravelNewsModel]
    private var paginationEvent: ((_ index: Int) -> Void)?
    
    init(
        items: Binding<[TravelNewsModel]>,
        paginationEvent: ((_ index: Int) -> Void)? = nil
    ) {
        self._items = items
        self.paginationEvent = paginationEvent
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
                    .onAppear {
                        paginationEvent?(i)
                    }
                }
            }).padding(.vertical, 25)
        }
    }
}
#if DEBUG
#Preview {
    TravelNewsMiniListView(items: .constant([
        TravelNewsModel.dummy,
        TravelNewsModel.dummy,
        TravelNewsModel.dummy,
        TravelNewsModel.dummy
    ]))
}
#endif
