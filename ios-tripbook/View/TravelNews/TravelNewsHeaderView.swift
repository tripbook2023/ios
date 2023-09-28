//
//  TravelNewsHeaderView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/16.
//

import SwiftUI

/// 여행 소식 Header View
/// - Author: 김민규
/// - Date: 2023/05/16
struct TravelNewsHeaderView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("Logo/Black")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            
            Spacer()
            
            NavigationLink(destination: EmptyView()) {
                TBIcon.search.iconSize(size: .medium)
                    .foregroundColor(TBColor.grayscale._90)
            }
            NavigationLink(destination: NotificationView()) {
                TBIcon.bell.iconSize(size: .medium)
                    .foregroundColor(TBColor.grayscale._90)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct TravelNewsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsHeaderView()
    }
}
