//
//  SignupProfileImageViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/17.
//

import Foundation
import SwiftUI
import UIKit

class SignupProfileImageViewModel: ObservableObject {
    @Published var isShowOptionView: Bool = false
    @Published var navigationTrigger: Bool = false
    
    @Published var isNavigateImagePickerView: Bool = false
    @Published var isNavigateCameraView: Bool = false
    
    @Published var profileImage: UIImage? = nil
}

extension SignupProfileImageViewModel: SignupProfileImageViewDelegate {
    func didTapImageButton() {
        self.isShowOptionView = true
    }
    
    func didTapSkipButton() {
        self.profileImage = nil
        self.navigationTrigger.toggle()
    }
    
    func didTapDoneButton() {
        self.navigationTrigger.toggle()
    }
}

extension SignupProfileImageViewModel: SignupProfileImageSelectOptionViewDelegate {
    func didTapCancelButton() {
        self.isShowOptionView = false
    }
    
    func didTapSelectPhotoButton() {
        self.isShowOptionView = false
        self.isNavigateImagePickerView = true
    }
    
    func didTapCameraButton() {
        self.isShowOptionView = false
        self.isNavigateCameraView = true
    }
    
    func didTapUseDefaultImageButton() {
        self.isShowOptionView = false
        self.profileImage = nil
    }
}
