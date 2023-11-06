//
//  RegisterTravelNewsView.swift
//  ios-tripbook
//
//  Created by 박세리 on 2023/11/03.
//

import UIKit
import SwiftUI
import SnapKit

struct RegisterTravelNewsView : UIViewControllerRepresentable {
    
    typealias UIViewControllerType = RegisterTravelReportVC
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return RegisterTravelReportVC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

class RegisterTravelReportVC: UIViewController, UINavigationControllerDelegate {
    
    private var imagePicker: UIImagePickerController!
    private var selectedCoverImage: UIImage?
    
    private var headerView: UIView!
    private var backButton: UIButton!
    private var registerButton: UIButton!
    
    private var coverImageView: UIImageView!
    private var coverPhotoButton: UIButton!
    private var photoImageView: UIImageView!
    private var photoLabel: UILabel!
    private var titleTextView: UITextView!
    private var titlePlaceHolderLabel: UILabel!
    private var titleTextCountLabel: UILabel!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var footerScrollView: UIScrollView!
    private var textButton: UIButton!
    private var textBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeHeaderView()
        makeCover()
        makeFooter()
        
//        coverPhotoButtonView.isUserInteractionEnabled = true
//        coverPhotoButtonView.addGestureRecognizer(.init(target: self, action: #selector(handleTap)))
        
        textButton.addTarget(self, action: #selector(tapTextButton), for: .touchUpInside)
        textBackButton.addTarget(self, action: #selector(tapBackTextButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(tapRegisterButton), for: .touchUpInside)
        coverPhotoButton.addTarget(self, action: #selector(tapCoverImageButton), for: .touchUpInside)
    }
    
    @objc func tapTextButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.footerScrollView.contentOffset.x = UIScreen.main.bounds.size.width
        }
      }
    
    @objc func tapBackTextButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.footerScrollView.contentOffset.x = 0
        }
      }
    
    @objc func tapRegisterButton(_ sender: UIButton) {
        print("등록 등록")
      }
    
    @objc func tapCoverImageButton(_ sender: UIButton) {
        self.show(imagePicker, sender: nil)
      }
    
    private func makeHeaderView() {
        headerView = UIView()
        
        backButton = UIButton()
        backButton.setImage(UIImage(named: "Before/01"), for: .normal)
        backButton.tintColor = .black
        
        let headerTitleLabel = UILabel()
        headerTitleLabel.text = "여행 소식 등록"
        headerTitleLabel.font = .init(name: "SUIT-Medium", size: 16)
        
        headerView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        registerButton = UIButton()
        
        let customFont = UIFont(name: "SUIT-Medium", size: 16)

        let attributes: [NSAttributedString.Key : Any] = [
            .font: customFont!,
            .foregroundColor: UIColor(red: 0.3, green: 0.27, blue: 0.26, alpha: 1)
        ]

        let attributedTitle = NSAttributedString(string: "등록", attributes: attributes)

        registerButton.setAttributedTitle(attributedTitle, for: .normal)
        
        registerButton.backgroundColor = UIColor(red: 0.88, green: 0.86, blue: 0.86, alpha: 1)
        registerButton.layer.cornerRadius = 6
        
        headerView.addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        headerView.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(32)
            make.width.equalTo(48)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    private func makeCover() {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        contentView = UIView()
        contentView.isUserInteractionEnabled = true
        scrollView.addSubview(contentView)
        scrollView.isScrollEnabled = true
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(1000)
        }
        
        let coverContainerView = UIView()
        coverContainerView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1).withAlphaComponent(0.3)
        
        contentView.addSubview(coverContainerView)
        coverContainerView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(354)
        }
        
        coverImageView = UIImageView()
        coverImageView.contentMode = .scaleAspectFill
        
        coverContainerView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coverPhotoButton = UIButton()
        coverPhotoButton.backgroundColor = .clear
        
        coverContainerView.addSubview(coverPhotoButton)
        coverPhotoButton.snp.makeConstraints { make in
            make.height.equalTo(206)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        photoImageView = UIImageView(image: UIImage(named: "Picture")?.withRenderingMode(.alwaysTemplate))
        photoImageView.tintColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        
        coverPhotoButton.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(110)
        }
        
        photoLabel = UILabel()
        photoLabel.text = "사진을 등록해 주세요."
        photoLabel.font = UIFont(name: "SUIT-Medium", size: 10)
        photoLabel.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        
        coverPhotoButton.addSubview(photoLabel)
        photoLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        titlePlaceHolderLabel = UILabel()
        titlePlaceHolderLabel.text = "제목을 입력해 주세요"
        titlePlaceHolderLabel.font = UIFont(name: "SUIT-Bold", size: 24)
        titlePlaceHolderLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titlePlaceHolderLabel.layer.shadowColor = UIColor(red: 0.055, green: 0.047, blue: 0.047, alpha: 0.2).cgColor
        titlePlaceHolderLabel.layer.shadowOpacity = 1
        titlePlaceHolderLabel.layer.shadowRadius = 4
        titlePlaceHolderLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        coverContainerView.addSubview(titlePlaceHolderLabel)
        titlePlaceHolderLabel.snp.makeConstraints { make in
            make.top.equalTo(coverPhotoButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        titleTextView = UITextView()
        titleTextView.delegate = self
        titleTextView.font = UIFont(name: "SUIT-Bold", size: 24)
        titleTextView.backgroundColor = .clear
        titleTextView.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titleTextView.textContainer.maximumNumberOfLines = 2
        titleTextView.layer.shadowColor = UIColor(red: 0.055, green: 0.047, blue: 0.047, alpha: 0.2).cgColor
        titleTextView.layer.shadowOpacity = 1
        titleTextView.layer.shadowRadius = 4
        titleTextView.layer.shadowOffset = CGSize(width: 0, height: 0)

        coverContainerView.addSubview(titleTextView)
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(coverPhotoButton.snp.bottom)
            make.height.equalTo(70)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        titleTextCountLabel = UILabel()
        titleTextCountLabel.text = "0"
        titleTextCountLabel.textColor = UIColor(red: 1, green: 0.76, blue: 0.58, alpha: 1)
        titleTextCountLabel.font = UIFont(name: "SUIT-Medium", size: 10)
        titleTextCountLabel.layer.shadowColor = UIColor(red: 0.055, green: 0.047, blue: 0.047, alpha: 0.2).cgColor
        titleTextCountLabel.layer.shadowOpacity = 1
        titleTextCountLabel.layer.shadowRadius = 4
        titleTextCountLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        let maxTitleCountLabel = UILabel()
        maxTitleCountLabel.text = "/30"
        maxTitleCountLabel.textColor = UIColor(red: 0.94, green: 0.93, blue: 0.92, alpha: 1)
        maxTitleCountLabel.font = UIFont(name: "SUIT-Medium", size: 10)
        maxTitleCountLabel.layer.shadowColor = UIColor(red: 0.055, green: 0.047, blue: 0.047, alpha: 0.2).cgColor
        maxTitleCountLabel.layer.shadowOpacity = 1
        maxTitleCountLabel.layer.shadowRadius = 4
        maxTitleCountLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        let titleCountStackView = UIStackView()
        titleCountStackView.addArrangedSubview(titleTextCountLabel)
        titleCountStackView.addArrangedSubview(maxTitleCountLabel)
        
        coverContainerView.addSubview(titleCountStackView)
        titleCountStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    
        
        
        // add more comp
        
        
    }
    
    private func makeFooter() {
        let footerContainerView = UIView()
        footerContainerView.backgroundColor = .cyan
        
        view.addSubview(footerContainerView)
        footerContainerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        let contentCountLabel = UILabel()
        contentCountLabel.text = "1000"
        footerContainerView.addSubview(contentCountLabel)
        contentCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        footerScrollView = UIScrollView()
        footerScrollView.isScrollEnabled = false
        footerContainerView.addSubview(footerScrollView)
        footerScrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(48)
        }

        
        let verticalDivider = UIView()
        verticalDivider.backgroundColor = UIColor(red: 0.94, green: 0.93, blue: 0.92, alpha: 1)
        footerScrollView.addSubview(verticalDivider)
        verticalDivider.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }


        let actionView = UIView()
        footerScrollView.addSubview(actionView)
        actionView.snp.makeConstraints { make in
            make.width.equalTo(footerContainerView.snp.width)
            make.height.equalTo(48)
            make.top.bottom.leading.equalToSuperview()
        }
        
        let keyboardButton = UIButton()
        keyboardButton.setImage(UIImage(named: "Keyboard"), for: .normal)
        keyboardButton.tintColor = UIColor(red: 0.5, green: 0.45, blue: 0.44, alpha: 1)
        
        let horizontalDivider = UIView()
        horizontalDivider.backgroundColor = UIColor(red: 0.88, green: 0.86, blue: 0.86, alpha: 1)
        
        textButton = UIButton()
        textButton.setImage(UIImage(named: "Txt"), for: .normal)
        textButton.tintColor = UIColor(red: 0.5, green: 0.45, blue: 0.44, alpha: 1)
        
        let imageButton = UIButton()
        imageButton.setImage(UIImage(named: "Picture"), for: .normal)
        imageButton.tintColor = UIColor(red: 0.5, green: 0.45, blue: 0.44, alpha: 1)
        
        let locationButton = UIButton()
        locationButton.setImage(UIImage(named: "Location/01"), for: .normal)
        locationButton.tintColor = UIColor(red: 0.5, green: 0.45, blue: 0.44, alpha: 1)
        
        let draftButton = UIButton()
        let customFont = UIFont(name: "SUIT-Medium", size: 14)
        let draftAtts: [NSAttributedString.Key : Any] = [
            .font: customFont!,
            .foregroundColor: UIColor(red: 0.62, green: 0.59, blue: 0.58, alpha: 1)
        ]

        let draftAttString = NSAttributedString(string: "임시저장⛄️", attributes: draftAtts)

        draftButton.setAttributedTitle(draftAttString, for: .normal)
        
        
        actionView.addSubview(keyboardButton)
        keyboardButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        actionView.addSubview(horizontalDivider)
        horizontalDivider.snp.makeConstraints { make in
            make.leading.equalTo(keyboardButton.snp.trailing).offset(14)
            make.width.equalTo(1)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        actionView.addSubview(textButton)
        textButton.snp.makeConstraints { make in
            make.leading.equalTo(horizontalDivider.snp.trailing).offset(14)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        actionView.addSubview(imageButton)
        imageButton.snp.makeConstraints { make in
            make.leading.equalTo(textButton.snp.trailing).offset(14)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        actionView.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.leading.equalTo(imageButton.snp.trailing).offset(14)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        actionView.addSubview(draftButton)
        draftButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }

        let secondView = UIView()
        footerScrollView.addSubview(secondView)
        secondView.snp.makeConstraints { make in
            make.width.equalTo(footerContainerView.snp.width)
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(actionView.snp.trailing)
            make.trailing.equalToSuperview()
        }
        
        textBackButton = UIButton()
        textBackButton.setImage(UIImage(named: "Before/02"), for: .normal)
        textBackButton.tintColor = UIColor(red: 0.5, green: 0.45, blue: 0.44, alpha: 1)
        
        let titleButton = UIButton()
        let textAtts: [NSAttributedString.Key : Any] = [
            .font: customFont!,
            .foregroundColor: UIColor(red: 0.62, green: 0.59, blue: 0.58, alpha: 1)
        ]
        let titleAttString = NSAttributedString(string: "제목", attributes: textAtts)
        titleButton.setAttributedTitle(titleAttString, for: .normal)
        
        let subtitleButton = UIButton()
        let subtitleAttString = NSAttributedString(string: "소제목", attributes: textAtts)
        subtitleButton.setAttributedTitle(subtitleAttString, for: .normal)
        
        let contentButton = UIButton()
        let contentAttString = NSAttributedString(string: "본문", attributes: textAtts)
        contentButton.setAttributedTitle(contentAttString, for: .normal)
        
        let boldButton = UIButton()
        let boldFont = UIFont(name: "SUIT-Bold", size: 14)
        let boldAtts: [NSAttributedString.Key : Any] = [
            .font: boldFont!,
            .foregroundColor: UIColor(red: 0.62, green: 0.59, blue: 0.58, alpha: 1)
        ]
        let boldAttString = NSAttributedString(string: "B", attributes: boldAtts)
        boldButton.setAttributedTitle(boldAttString, for: .normal)
        
        secondView.addSubview(textBackButton)
        textBackButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        secondView.addSubview(titleButton)
        titleButton.snp.makeConstraints { make in
            make.leading.equalTo(textBackButton.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        
        secondView.addSubview(subtitleButton)
        subtitleButton.snp.makeConstraints { make in
            make.leading.equalTo(titleButton.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        
        secondView.addSubview(contentButton)
        contentButton.snp.makeConstraints { make in
            make.leading.equalTo(subtitleButton.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        
        secondView.addSubview(boldButton)
        boldButton.snp.makeConstraints { make in
            make.leading.equalTo(contentButton.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
}

extension RegisterTravelReportVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            selectedCoverImage = selectedImage
            coverImageView.image = selectedImage
            photoImageView.isHidden = true
            photoLabel.isHidden = true
        }
        dismiss(animated: true, completion: nil) // 이미지 선택 화면 닫기
    }
}

extension RegisterTravelReportVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
        if titleTextView.text.count == 0 {
            titlePlaceHolderLabel.isHidden = false
        } else {
            titlePlaceHolderLabel.isHidden = true
        }
        
        if titleTextView.text.count <= 30 {
            titleTextCountLabel.text = "\(titleTextView.text.count)"
        } else {
            let text = titleTextView.text ?? ""
            let endIndex = text.index(text.startIndex, offsetBy: 29) // 30번째 글자 직전까지의 인덱스
            let truncatedString = String(text[..<endIndex]) // 30번째 글자 직전까지의 문자열을 추출
            titleTextView.text = truncatedString
        }
    }
}
