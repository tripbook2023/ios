//
//  RegisterTravelNewsView.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/27/23.
//

import SwiftUI

struct RegisterTravelNewsView: View {
    private var editItem: TravelNewsModel?
    
    init(editItem: TravelNewsModel? = nil) {
        self.editItem = editItem
    }
    
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
            viewModel.tempItem = editItem
            viewModel.isEditing = editItem != nil
        }
        .sheet(
            isPresented: $viewModel.isShowSearchLocationView,
            content: {
                TravelNewsSearchLocationView(registerViewModel: viewModel)
            }
        )
        .fullScreenCover(
            isPresented: $viewModel.isShowTemporaryStorageListView,
            content: {
                TravelNewsTemporaryStorageListView(viewModel: viewModel)
            }
        )
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    RegisterTravelNewsView()
}
