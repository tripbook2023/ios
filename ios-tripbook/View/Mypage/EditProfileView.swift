//
//  EditProfileView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/11/03.
//

import SwiftUI
import Combine

import TBImagePicker

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = EditProfileViewModel()
    @State private var anyCancellable = Set<AnyCancellable>()
    
    private var deviceHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                TBAppBar(title: "프로필 수정") {
                    dismiss()
                }
                ZStack(alignment: .bottom) {
                    if let imagedata = viewModel.newProfileImageData {
                        Image(uiImage: UIImage(data: imagedata)!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(TBColor.grayscale._10, lineWidth: 0.57)
                            )
                    } else {
                        Image("DefaultProfileImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(TBColor.grayscale._10, lineWidth: 0.57)
                            )
                    }
                    HStack {
                        Spacer()
                        Button {
                            viewModel.isShowOptionView = true
                        } label: {
                            TBIcon.cameraFull.iconSize(size: .small)
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                                .background(.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(TBColor.grayscale._10, lineWidth: 0.5)
                                )
                        }
                    }
                    .frame(width: 80)
                }
                .padding(.top, 18)
                TBTextField(
                    title: "10자 이내 한글, 영문, 숫자 입력",
                    text: $viewModel.newName,
                    isValid: Binding(
                        get: { self.viewModel.warningMessage == nil },
                        set: { _ in }
                    ),
                    warningMessage: $viewModel.warningMessage,
                    onSubmitEvent: {
                        self.viewModel.checkNicknameDuplication()
                    }
                )
                Spacer()
                TBPrimaryButton(
                    title: "확인",
                    isEnabled: Binding(
                        get: { self.viewModel.warningMessage == nil },
                        set: { _ in }
                    ),
                    onClickedEvent: {
                        self.viewModel.updateProfile()
                    }
                )
                .padding(.vertical, 18)
            }
            .padding(.horizontal, 20)
            ProfileImageSelectOptionView(delgate: viewModel)
                .opacity(viewModel.isShowOptionView ? 1 : 0)
        }
        .fullScreenCover(isPresented: self.$viewModel.isShowImagePicker) {
            TBImagePickerView(
                .single,
                onFinish: { assetManagers in
                    assetManagers.first?.request(
                        size: .init(width: 140, height: 140),
                        completion: { image, _ in
                            viewModel.newProfileImageData = image?.jpegData(compressionQuality: 0.5)
                        }
                    )
                }
            )
        }
        .sheet(isPresented: self.$viewModel.isShowCameraView) {
            ProfileImageCameraView(
                isPresented: $viewModel.isShowCameraView
            ) { image in
                self.viewModel.newProfileImageData = image.jpegData(compressionQuality: 0.5)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            bind()
        }
        .navigationBarHidden(true)
    }
}

extension EditProfileView {
    private func bind() {
        viewModel.$isDismiss
            .filter { $0 }
            .sink { _ in
                self.dismiss()
            }
            .store(in: &anyCancellable)
        
        viewModel.$newName
            .sink { _ in
                self.viewModel.checkValidationNickname()
            }
            .store(in: &anyCancellable)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
