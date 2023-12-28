//
//  RegisterTravelNewsView.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/27/23.
//

import SwiftUI

struct RegisterTravelNewsView: View {
    @State private var isShowTemporaryStorageListView = false
    @State private var isShowSearchLocationView = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        RegisterTravelNewsEditerView(
            backButtonAction: {
                dismiss()
            },
            locationButtonAction: {
                isShowSearchLocationView = true
            },
            tempButtonButtonAction: {
                isShowTemporaryStorageListView = true
            }
        )
        .sheet(
            isPresented: $isShowSearchLocationView,
            content: {
                TravelNewsSearchLocationView()
            })
        .fullScreenCover(
            isPresented: $isShowTemporaryStorageListView,
            content: {
                TravelNewsTemporaryStorageListView()
            })
    }
}

#Preview {
    RegisterTravelNewsView()
}
