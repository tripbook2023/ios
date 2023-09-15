//
//  NotificationViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var isEdit = false
    @Published var isShowEditModal = false
}

extension NotificationViewModel: NotificationViewDelegate {
    func didTapNotificationItemView() {
        self.isShowEditModal = true
    }
}

extension NotificationViewModel: NotificationHeaderViewDelegate {
    func didTapEditButton() {
        self.isEdit.toggle()
    }
}

extension NotificationViewModel: NotificationItemViewDelegate {
    func didTapConfirmButton() {
        self.isShowEditModal = false
    }
    
    func didTapDismissButton() {
        self.isShowEditModal = false
    }
}
