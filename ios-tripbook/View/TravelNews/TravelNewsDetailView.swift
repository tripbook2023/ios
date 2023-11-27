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
        VStack {
            Text("DetailView")
        }
        .task {
            
            let api = TBTravelNewsAPI.search(accessToken: viewModel.tokenStorage.accessToken ?? "", id: "47")
            
            do {
                let data = try await viewModel.apiManager.request(api)
                let travel = try JSONDecoder().decode(TBTravelNewsResponse.self, from: data).toDomain
                
                print("data: \(travel)")
            } catch {
                print("ERROR: \(error)")
            }
        }
    }
}
