//
//  SignupProfileImagePickerView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/18.
//

import SwiftUI
import UIKit
import TBUtil

struct SignupProfileImagePickerView: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var image: Image?
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> SignupProfileImagePickerViewCoodinator {
        return SignupProfileImagePickerViewCoodinator(image: $image, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        
        pickerController.modalPresentationStyle = .fullScreen
        pickerController.sourceType = sourceType
        pickerController.allowsEditing = true
        pickerController.delegate = context.coordinator
        
        pickerController.navigationController?.navigationBar.tintColor = UIColor(cgColor: TBColor.grayscale.levels[10].cgColor!)
        
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}

class SignupProfileImagePickerViewCoodinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var image: Image?
    @Binding var isPresented: Bool
    
    init(image: Binding<Image?>, isPresented: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.image = Image(uiImage: image)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}