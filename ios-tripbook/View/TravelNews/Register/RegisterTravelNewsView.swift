//
//  RegisterTravelNewsView.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/27/23.
//

import SwiftUI
import Combine

struct RegisterTravelNewsView: View {
    private var editItem: TravelNewsModel?
    
    init(editItem: TravelNewsModel? = nil) {
        self.editItem = editItem
    }
    
    @StateObject private var viewModel = RegisterTravelNewsViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var anyCancellable = Set<AnyCancellable>()
    @State private var popupView: TBPopup.ViewType?
    
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
            bind()
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
        .showAlert(content: $popupView)
        .toolbar(.hidden, for: .navigationBar)
    }
}

extension RegisterTravelNewsView {
    private func bind() {
        viewModel.$message
            .filter { $0 != nil }
            .sink {
                popupView = .ruide(
                    title: $0!.0,
                    subTitle: $0!.1,
                    confirmButtonText: "확인",
                    didTapConfirmButton: {
                        viewModel.message = nil
                    }
                )
            }.store(in: &anyCancellable)
    }
}

#Preview {
    RegisterTravelNewsView()
}
