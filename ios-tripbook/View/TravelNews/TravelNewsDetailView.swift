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
    
    init(viewModel: TravelNewsDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
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
                    Text("content")
                    //content
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
