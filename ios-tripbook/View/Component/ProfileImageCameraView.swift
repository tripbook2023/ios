//
//  ProfileImageCameraView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/18.
//

import SwiftUI
import UIKit

struct ProfileImageCameraView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var onFinish: (UIImage) -> Void
    
    
    func makeCoordinator() -> ProfileImageCameraViewCoodinator {
        return ProfileImageCameraViewCoodinator(isPresented: $isPresented, onFinish: onFinish)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        
        pickerController.modalPresentationStyle = .fullScreen
        pickerController.sourceType = .camera
        pickerController.allowsEditing = true
        pickerController.delegate = context.coordinator
        
        pickerController.navigationController?.navigationBar.tintColor = UIColor(cgColor: TBColor.grayscale._80.cgColor!)
        
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}

class ProfileImageCameraViewCoodinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private var onFinish: (UIImage) -> Void
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>, onFinish: @escaping (UIImage) -> Void) {
        self.onFinish = onFinish
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.onFinish(image)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}
