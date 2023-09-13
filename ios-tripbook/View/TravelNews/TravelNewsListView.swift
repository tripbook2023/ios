//
//  TravelNewsListView.swift
//  ios-tripbook
//
//  Created by DDang on 7/15/23.
//

import SwiftUI

struct TravelNewsListView: View {
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("여행소식")
                    .font(.suit(.bold, size: 20))
                    .foregroundColor(TBColor.grayscale._80)
                Spacer()
                Button(action: {
                    
                }) {
                    TBIcon.filter.iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._70)
                }
            }
            
            VStack(spacing: 20) {
                ForEach(0..<3, id: \.self) { _ in
                    TravelNewsListItemView()
                }
            }
        }.padding(.horizontal, 20)
    }
}

struct TravelNewsListView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsListView()
    }
}
