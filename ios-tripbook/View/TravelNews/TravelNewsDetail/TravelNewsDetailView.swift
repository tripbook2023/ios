//
//  TravelNewsDetailView.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/27.
//

import Foundation
import SwiftUI
import Combine

struct TravelNewsDetailView: View {
    @ObservedObject var viewModel: TravelNewsDetailViewModel
    
    @State private var webViewHeight: CGFloat = .zero
    
    init(viewModel: TravelNewsDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var deviceHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var body: some View {
        VStack {
            
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    coverView()
                    authorView()
                    if let content = viewModel.travelNews?.content {
                        htmlView(content: content)
                    }
                }
                
            }
            .ignoresSafeArea()
            .toolbarBackground(.hidden, for: .navigationBar)
            .onAppear {
                Task {
                    await viewModel.loadData()
                }
            }
            .overlay {
                VStack {
                    Spacer()
                    bottomView()
                }
            }
        }
    }
    
    func profileView(urlString: String) -> some View {
            AsyncImage(url: URL(string: urlString))
            .frame(width: 14, height: 14)
            .clipShape(Circle())
            .overlay {
                RoundedRectangle(cornerRadius: 9)
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(width: 18, height: 18)
            }
    }
    
    func authorView() -> some View {
        HStack(alignment: .center) {
            Spacer()
            
            if let urlString = viewModel.travelNews?.author.profileURL {
                profileView(urlString: urlString)
            }
            
            Text(viewModel.travelNews?.author.name ?? "name")
                .font(.suit(.bold, size: 12))
                .padding(.trailing, 20)
        }
        .frame(width: deviceWidth, height: 48)
        .background {
            Rectangle()
                .fill(TBColor.grayscale._1)
        }
    }
    
    func coverView() -> some View {
        ZStack(alignment: .topLeading) {
            if let urlString = viewModel.travelNews?.thumbnailURL {
                AsyncImage(url: URL(string: urlString)) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: deviceWidth, height: deviceHeight-80)
                                .clipped()
                        default:
                            Text("Failed to load the image")
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    if let urlString = viewModel.travelNews?.author.profileURL {
                        profileView(urlString: urlString)
                    }
                    
                    Text(viewModel.travelNews?.author.name ?? "name")
                        .foregroundColor(.white)
                        .font(.suit(.bold, size: 12))
                }
                
                Text(viewModel.travelNews?.title ?? "aa")
                    .font(.suit(.bold, size: 24))
                    .foregroundColor(.white)
            }
            .offset(.init(width: 20, height: 210))
        }
        .frame(width: deviceWidth, height: deviceHeight-80)
    }
    
    func htmlView(content: String) -> some View {
        HTMLView(htmlString: content, contentHeight: $webViewHeight)
            .frame(width: deviceWidth, height: webViewHeight)
    }
    
    func bottomView() -> some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(TBColor.grayscale._50)
                .frame(width: deviceWidth, height: 1)
                
            HStack {
                Button {
                    //
                } label: {
                    Image("Like")
                        .foregroundColor(TBColor.grayscale._50)
                }
                .frame(width: 24, height: 24)
                
                Text("\(viewModel.travelNews?.likeCount ?? 0)")
                    .font(.suit(.medium, size: 10))
                    .foregroundColor(TBColor.grayscale._50)
                
                Spacer()
            }
            .frame(height: 56)
            .padding(.horizontal, 20)
        }
        .background(.white)
    }
}
