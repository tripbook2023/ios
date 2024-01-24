//
//  RegisterTravelNewsView.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/27/23.
//

import SwiftUI

struct RegisterTravelNewsView: View {
    @StateObject private var viewModel = RegisterTravelNewsViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        RegisterTravelNewsEditerView(
            viewModel: viewModel,
            backButtonAction: {
                dismiss()
            }
        )
        .onAppear {
            viewModel.fatchTempList()
        }
        .sheet(
            isPresented: $viewModel.isShowSearchLocationView,
            content: {
                TravelNewsSearchLocationView(registerViewModel: viewModel)
            })
        .fullScreenCover(
            isPresented: $viewModel.isShowTemporaryStorageListView,
            content: {
                TravelNewsTemporaryStorageListView(viewModel: viewModel)
            })
    }
}

#Preview {
    RegisterTravelNewsView()
}
