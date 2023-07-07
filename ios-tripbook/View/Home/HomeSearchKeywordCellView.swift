//
//  HomeSearchKeywordCellView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/26.
//

import SwiftUI

struct HomeSearchKeywordCellView: View {
    let cellText: String
    
    var body: some View {
        HStack {
            Text(self.cellText)
                .font(.suit(.regular, size: 18))
            Spacer()
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}

struct HomeSearchKeywordCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchKeywordCellView(cellText: "강릉 바다")
    }
}
