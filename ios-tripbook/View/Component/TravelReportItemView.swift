//
//  FeedItemView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/26.
//

import SwiftUI

/// Half 여행 기록 Item View
/// - Author: 김민규
/// - Date: 2023/05/14
struct HalfTravelReportItemView: View {
    
    /// 해당 Item View의 Header 표시 Type
    enum type {
        /// 프로필 정보 표시
        case profile
        
        /// 날짜 및 위치 표시
        case information
    }
    
    /// 여행 기록 Item View - View Model
    @ObservedObject var viewModel: TravelReportItemViewModel
    /// Header 표시 Type 명시
    var type: type
    
    /// Half 여행 기록 Item View Initializer
    /// - Parameters:
    ///     - data: 여행 기록 Data Model
    ///     - type: Header 표시 Type
    init(
        _ data: TravelReportModel,
        type: type = .profile
    ) {
        self.viewModel = TravelReportItemViewModel(data)
        self.type = type
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            switch self.type {
            case .profile:
                HStack(spacing: 7) {
//                    if let profileImage = self.viewModel.data.author.profileImage {
//                        Image(uiImage: profileImage)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 29, height: 29)
//                            .cornerRadius(29 / 2)
//                            .clipped()
//                    } else {
                        RoundedRectangle(cornerRadius: 29 / 2)
                            .frame(width: 29, height: 29)
//                    }
                    Text(self.viewModel.data.author.name)
                        .font(.suit(.regular, size: 10))
                }
            case .information:
                Text("\(self.viewModel.data.createdAt, formatter: self.viewModel.dateFormat)\n\(self.viewModel.data.locate)")
                    .font(.suit(.bold, size: 15))
            }
            
            Image(uiImage: self.viewModel.data.image)
                .resizable()
                .scaledToFill()
                .frame(width: 178, height: 206)
                .clipped()
            
            DocumentActionBar(
                self.$viewModel.data,
                delegate: self.viewModel
            )
            
            Text(self.viewModel.data.title)
                .font(.suit(.medium, size: 12))
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
        }.frame(width: 178)
    }
}

/// 여행 기록 Item View
/// - Author: 김민규
/// - Date: 2023/05/01
struct TravelReportItemView: View {
    /// 여행 기록 Item View - View Model
    @ObservedObject var viewModel: TravelReportItemViewModel
    
    /// 여행 기록 Item View Initializer
    /// - Parameters:
    ///     - data: 여행 기록 Data Model
    init(_ data: TravelReportModel) {
        self.viewModel = TravelReportItemViewModel(data)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 7) {
//                if let profileImage = self.viewModel.data.author.profileImage {
//                    Image(uiImage: profileImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 38, height: 38)
//                        .cornerRadius(38 / 2)
//                        .clipped()
//                } else {
                    RoundedRectangle(cornerRadius: 38 / 2)
                        .frame(width: 38, height: 38)
//                }
                Text(self.viewModel.data.author.name)
                    .font(.suit(.regular, size: 13))
            }
            
            Image(uiImage: self.viewModel.data.image)
                .resizable()
                .scaledToFill()
                .frame(width: 359, height: 267)
                .cornerRadius(20.0)
                .clipped()
            
            DocumentActionBar(
                self.$viewModel.data,
                delegate: self.viewModel,
                canShare: true
            ).padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            
            Text(self.viewModel.data.title)
                .font(.suit(.medium, size: 12))
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            
            Text(self.viewModel.data.content)
                .font(.suit(.regular, size: 12))
                .lineLimit(2)
                .frame(width: UIScreen.main.bounds.width - 36)
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
        }
    }
}

struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HalfTravelReportItemView(SampleTravelReportModel())
            .previewLayout(.sizeThatFits)
            .padding()
            
            TravelReportItemView(SampleTravelReportModel())
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
