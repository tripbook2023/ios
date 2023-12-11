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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ZStack(alignment: .top) {
                    if let urlString = viewModel.travelNews?.thumbnailURL {
                        AsyncImage(url: URL(string: urlString))
                    }
                    
                    Text(viewModel.travelNews?.title ?? "aa")
                        .font(.suit(.bold, size: 24))
                        .foregroundColor(.white)
                        .offset(.init(width: 0, height: 210))
                }
                
                HStack(alignment: .center) {
                    if let urlString = viewModel.travelNews?.author.profileURL {
                        AsyncImage(url: URL(string: urlString))
                            .frame(width: 14, height: 14)
                    }
                    Text(viewModel.travelNews?.author.name ?? "name")
                }
                
                VStack {
                    //content
                    let htmlString = """
                      <h1>Hello, SwiftUI with WebView!</h1>
                      <p>This is an example of displaying HTML in a WKWebView using SwiftUI.</p>
                    """
                    
                    HTMLView(htmlString: viewModel.travelNews?.content ?? htmlString, contentHeight: $webViewHeight)
                        .frame(width: deviceWidth, height: webViewHeight)

//                    HTMLView(text: viewModel.travelNews?.content ?? htmlString)
//                        .frame(width: deviceWidth)
//                        .frame(minHeight: 100)
//                        .scrollDisabled(true)
                }
                
                Spacer()
                
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}
