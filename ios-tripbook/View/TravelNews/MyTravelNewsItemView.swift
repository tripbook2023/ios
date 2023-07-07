//
//  TravelNewsUserItemView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/17.
//

import SwiftUI

/// 본인 여행기록 Item View
/// - Author: 김민규
/// - Date: 2023/05/20
struct MyTravelNewsItemView: View {
    @ObservedObject var viewModel: MyTravelNewsItemViewModel
    
    /// View 너비
    var width: CGFloat = 332
    /// View 높이
    var height: CGFloat = 194
    
    init(_ data: MyTravelNewsModel) {
        self.viewModel = MyTravelNewsItemViewModel(data)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .overlay(
                    Image(uiImage: self.viewModel.data.image)
                        .resizable()
                        .scaledToFill()
                )
            
            Color(red: 120 / 255, green: 120 / 255, blue: 120 / 255)
                .opacity(0.4)
            
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading) {
                        Text(self.viewModel.data.title)
                            .font(.suit(.bold, size: 20))
                            .foregroundColor(.white)
                        Text("\(self.viewModel.data.createdAt, formatter: self.viewModel.dateFormatter)")
                            .font(.suit(.bold, size: 16))
                            .foregroundColor(.white)
                    }.frame(maxWidth: width * 0.5)
                    
                    Spacer()
                    
                    self.loadStatusLabelView()
                }
                
                Spacer()
                
                DocumentActionBar(
                    self.$viewModel.data,
                    delegate: self.viewModel,
                    canShare: true,
                    color: .white
                )
            }.padding()
        }
        .frame(width: self.width, height: self.height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    /// 승인 상태 Label View
    @ViewBuilder
    func loadStatusLabelView() -> some View {
        switch self.viewModel.data.status {
        case .done:
            if !self.viewModel.data.isApprovedDateOver(days: 3) {
                Text("승인완료")
                    .frame(width: 62, height: 22)
                    .font(.suit(.regular, size: 11))
                    .foregroundColor(.white)
                    .background(Color(red: 255 / 255, green: 78 / 255, blue: 0 / 255))
                    .cornerRadius(5)
            } else {
                EmptyView()
            }
        case .waiting:
            Text("승인대기중")
                .frame(width: 62, height: 22)
                .font(.suit(.regular, size: 11))
                .foregroundColor(.init(red: 151 / 255, green: 151 / 255, blue: 151 / 255))
                .background(Color(red: 234 / 255, green: 234 / 255, blue: 234 / 255))
                .cornerRadius(5)
        }
    }
}

struct MyTravelNewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyTravelNewsItemView(SampleMyTravelNewsModel(.waiting))
                .previewLayout(.sizeThatFits)
                .padding()
            
            MyTravelNewsItemView(SampleMyTravelNewsModel(.done))
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
