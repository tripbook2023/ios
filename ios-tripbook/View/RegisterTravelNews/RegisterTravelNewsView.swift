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
    
    private var backButtonAction: () -> Void
    
    init(
        backButtonAction: @escaping () -> Void = {}
    ) {
        self.backButtonAction = backButtonAction
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return RegisterTravelReportVC(
            backButtonAction: backButtonAction
        )
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

#Preview(body: {
    RegisterTravelNewsView()
})

class RegisterTravelReportVC: UIViewController, UINavigationControllerDelegate {
    
    private var isCoverImage: Bool = false
    
    private var imagePicker: UIImagePickerController!
    private var selectedCoverImage: UIImage?
    
    private var headerView: UIView!
    private var backButton: UIButton!
    private var registerButton: UIButton!
    
    private var coverContainerView: UIView!
    private var coverImageView: UIImageView!
    private var coverPhotoButton: UIButton!
    private var photoImageView: UIImageView!
    private var photoLabel: UILabel!
    private var titleTextView: UITextView!
    private var titlePlaceHolderLabel: UILabel!
    private var titleTextCountLabel: UILabel!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var contentTextView: UITextView!
    private var contentPlaceHolderLabel: UILabel!
    
    private var footerScrollView: UIScrollView!
    private var contentCountLabel: UILabel!
    private var keyboardButton: UIButton!
    private var textButton: UIButton!
    private var imageButton: UIButton!
    
    private var textBackButton: UIButton!
    private var titleButton: UIButton!
    private var subtitleButton: UIButton!
    private var contentButton: UIButton!
    private var boldButton: UIButton!
    
    private var backButtonAction: () -> Void
    
    init(
        backButtonAction: @escaping () -> Void = {}
    ) {
        self.backButtonAction = backButtonAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeHeaderView()
        makeCover()
        makeContent()
        makeFooter()
        
        backButton.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        keyboardButton.addTarget(self, action: #selector(tapKeyboardButton), for: .touchUpInside)
        textButton.addTarget(self, action: #selector(tapTextButton), for: .touchUpInside)
        textBackButton.addTarget(self, action: #selector(tapBackTextButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(tapRegisterButton), for: .touchUpInside)
        coverPhotoButton.addTarget(self, action: #selector(tapCoverImageButton), for: .touchUpInside)
        
        imageButton.addTarget(self, action: #selector(tapImageButton), for: .touchUpInside)
        
        titleButton.addTarget(self, action: #selector(tapTitleButton), for: .touchUpInside)
        subtitleButton.addTarget(self, action: #selector(tapSubtitleButton), for: .touchUpInside)
        contentButton.addTarget(self, action: #selector(tapContentButton), for: .touchUpInside)
        boldButton.addTarget(self, action: #selector(tapBoldButton), for: .touchUpInside)
    }
    
    @objc
    func tapBackButton(_ sender: UIButton) {
        backButtonAction()
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
        let htmlService = HTMLEditorService()
        
        if let html = contentTextView.attributedText.toHTML(),
        let body = htmlService.extractBodyContent(from: html) {
            let style = htmlService.extractStyleContent(from: html)
            let dic = htmlService.convertStyleToDic(form: style)
            let result = htmlService.apply(style: dic, body: body)
            
            print(result!)
        }
      }
    
    @objc func tapCoverImageButton(_ sender: UIButton) {
        self.isCoverImage = true
        self.show(imagePicker, sender: nil)
      }
    
    @objc func tapKeyboardButton(_ sender: UIButton) {
        self.contentTextView.resignFirstResponder()
        self.titleTextView.resignFirstResponder()
      }
    
    @objc func tapImageButton(_ sender: UIButton) {
        self.show(imagePicker, sender: nil)
      }
    
    @objc func tapTitleButton(_ sender: UIButton) {
        changeTextSize(20)
      }
    
    @objc func tapSubtitleButton(_ sender: UIButton) {
        changeTextSize(16)
      }
    
    @objc func tapContentButton(_ sender: UIButton) {
        changeTextSize(14)
      }
    
    @objc func tapBoldButton(_ sender: UIButton) {
        toggleTextWeightBold()
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
            make.height.greaterThanOrEqualToSuperview()
        }
        
        coverContainerView = UIView()
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
        titleTextView.tag = 0
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
    }
    
    private func makeContent() {
        contentPlaceHolderLabel = UILabel()
        contentPlaceHolderLabel.text = "최소 800자 이상의 글자수를 작성해주세요"
        contentPlaceHolderLabel.font = UIFont(name: "SUIT-Medium", size: 14)
        contentPlaceHolderLabel.textColor = UIColor(red: 0.78, green: 0.75, blue: 0.74, alpha: 1)
        
        contentView.addSubview(contentPlaceHolderLabel)
        contentPlaceHolderLabel.snp.makeConstraints { make in
            make.top.equalTo(coverContainerView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        contentTextView = UITextView()
        contentTextView.font = UIFont(name: "SUIT-Medium", size: 14)
        contentTextView.tag = 1
        contentTextView.backgroundColor = .clear
        contentTextView.delegate = self
        contentView.addSubview(contentTextView)
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(coverContainerView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-32)
        }
        contentTextView.isScrollEnabled = false
    }
    
    private func makeFooter() {
        let footerContainerView = UIView()
        footerContainerView.backgroundColor = .white
        
        view.addSubview(footerContainerView)
        footerContainerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        contentCountLabel = UILabel()
        contentCountLabel.text = "0"
        contentCountLabel.font = UIFont(name: "SUIT-Medium", size: 10)
        contentCountLabel.textColor = UIColor(red: 0.78, green: 0.13, blue: 0, alpha: 1)
        
        let contentMaxCountLabel = UILabel()
        contentMaxCountLabel.text = "/10,000"
        contentMaxCountLabel.font = UIFont(name: "SUIT-Medium", size: 10)
        contentMaxCountLabel.textColor = UIColor(red: 0.78, green: 0.75, blue: 0.74, alpha: 1)
        
        let contentStackView = UIStackView()
        contentStackView.addArrangedSubview(contentCountLabel)
        contentStackView.addArrangedSubview(contentMaxCountLabel)
        
        footerContainerView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
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
        
        keyboardButton = UIButton()
        keyboardButton.setImage(UIImage(named: "Keyboard"), for: .normal)
        keyboardButton.tintColor = UIColor(red: 0.5, green: 0.45, blue: 0.44, alpha: 1)
        
        let horizontalDivider = UIView()
        horizontalDivider.backgroundColor = UIColor(red: 0.88, green: 0.86, blue: 0.86, alpha: 1)
        
        textButton = UIButton()
        textButton.setImage(UIImage(named: "Txt"), for: .normal)
        textButton.tintColor = UIColor(red: 0.5, green: 0.45, blue: 0.44, alpha: 1)
        
        imageButton = UIButton()
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
        
        titleButton = UIButton()
        let textAtts: [NSAttributedString.Key : Any] = [
            .font: customFont!,
            .foregroundColor: UIColor(red: 0.62, green: 0.59, blue: 0.58, alpha: 1)
        ]
        let titleAttString = NSAttributedString(string: "제목", attributes: textAtts)
        titleButton.setAttributedTitle(titleAttString, for: .normal)
        
        subtitleButton = UIButton()
        let subtitleAttString = NSAttributedString(string: "소제목", attributes: textAtts)
        subtitleButton.setAttributedTitle(subtitleAttString, for: .normal)
        
        contentButton = UIButton()
        let contentAttString = NSAttributedString(string: "본문", attributes: textAtts)
        contentButton.setAttributedTitle(contentAttString, for: .normal)
        
        boldButton = UIButton()
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
    
    private func changeTextSize(_ size: CGFloat) {
        
        if let selectedRange = contentTextView.selectedTextRange {
            // 텍스트 뷰 내에서 커서가 위치한 텍스트의 범위를 가져옵니다.
            let start = contentTextView.offset(from: contentTextView.beginningOfDocument, to: selectedRange.start)
            let end = contentTextView.offset(from: contentTextView.beginningOfDocument, to: selectedRange.end)
            
            // 커서가 위치한 텍스트의 범위를 식별합니다.
            let selectedTextRange = NSRange(location: start, length: end - start)
            
            // 원하는 글자 크기를 설정합니다.
            let fontSize: CGFloat = size
            
            // 글자 크기를 변경할 범위에 대해 적용합니다.
            if selectedTextRange.location != NSNotFound && selectedTextRange.length > 0 {
                let attributedText = NSMutableAttributedString(attributedString: contentTextView.attributedText)
                attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: selectedTextRange)
                
                // 변경된 속성을 텍스트 뷰에 설정합니다.
                contentTextView.attributedText = attributedText
            } else {
                // 선택된 텍스트 범위가 없을 때
                  if let currentPosition = contentTextView.selectedTextRange?.start {
                      // 커서의 현재 위치를 식별하고 해당 위치의 행을 찾습니다.
                      if let currentLineRange = contentTextView.tokenizer.rangeEnclosingPosition(currentPosition, with: .line, inDirection: UITextDirection(rawValue: 1)) {
                          // 텍스트 뷰 내의 현재 행 범위를 가져옵니다.
                          
                          // 원하는 글자 크기를 설정합니다.
                          let fontSize: CGFloat = size
                          
                          // 커서 위치에서 행 시작 위치와 끝 위치를 가져옵니다.
                          let start = contentTextView.offset(from: contentTextView.beginningOfDocument, to: currentLineRange.start)
                          let end = contentTextView.offset(from: contentTextView.beginningOfDocument, to: currentLineRange.end)
                          
                          // 글자 크기를 변경할 범위에 적용합니다.
                          let attributedText = NSMutableAttributedString(attributedString: contentTextView.attributedText)
                          attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: NSRange(location: start, length: end - start))
                          
                          // 변경된 속성을 텍스트 뷰에 설정합니다.
                          contentTextView.attributedText = attributedText
                      }
                  }
            }
        }
    }
    
    private func toggleTextWeightBold() {
        if let selectedRange = contentTextView.selectedTextRange {
               // 텍스트 뷰 내에서 커서가 위치한 텍스트의 범위를 가져옵니다.
               let start = contentTextView.offset(from: contentTextView.beginningOfDocument, to: selectedRange.start)
               let end = contentTextView.offset(from: contentTextView.beginningOfDocument, to: selectedRange.end)

               // 커서가 위치한 텍스트의 범위를 식별합니다.
               let selectedTextRange = NSRange(location: start, length: end - start)

               // 원하는 글꼴 두께를 설정합니다.
               let fontWeight: UIFont.Weight = .bold
               
               // 글꼴 두께를 변경할 범위에 대해 적용합니다.
               if selectedTextRange.location != NSNotFound && selectedTextRange.length > 0 {
                   let attributedText = NSMutableAttributedString(attributedString: contentTextView.attributedText)
                   
                   // 범위에 있는 텍스트 중에 bold 속성을 가진 글자가 있는지 확인한다.
                   var fonts: [String] = []
                   attributedText.enumerateAttribute(.font, in: selectedTextRange, options: []) { (value, range, stop) in
                       if let oldFont = value as? UIFont {
                           fonts.append(oldFont.fontName)
                       }
                   }
                   
                   let contianBold = fonts.contains(".SFUI-Bold")
                   
                   attributedText.enumerateAttribute(.font, in: selectedTextRange, options: []) { (value, range, stop) in
                       
                       if let oldFont = value as? UIFont {
                           if contianBold {
                               // 기존 글자 중 하나라도 bold 속성을 가진 경우, medium로 변경합니다.
                               let regularFont = UIFont.systemFont(ofSize: oldFont.pointSize, weight: .medium)
                               attributedText.addAttribute(.font, value: regularFont, range: range)
                           } else {
                               // 기존 글자 중 bold 속성이 없으면, bold로 변경합니다.
                               let boldFont = UIFont.systemFont(ofSize: oldFont.pointSize, weight: fontWeight)
                               attributedText.addAttribute(.font, value: boldFont, range: range)
                           }
                       }
                   }

                   // 변경된 속성을 텍스트 뷰에 설정합니다.
                   contentTextView.attributedText = attributedText
               } else {
                   // 선택된 텍스트 범위가 없을 때
                   if let currentPosition = contentTextView.selectedTextRange?.start {
                       // 커서의 현재 위치를 식별하고 해당 위치의 행을 찾습니다.
                       if let currentLineRange = contentTextView.tokenizer.rangeEnclosingPosition(currentPosition, with: .line, inDirection: UITextDirection(rawValue: 1)) {
                           // 텍스트 뷰 내의 현재 행 범위를 가져옵니다.

                           // 원하는 글꼴 두껈를 설정합니다.
                           let fontWeight: UIFont.Weight = .bold

                           // 커서 위치에서 행 시작 위치와 끝 위치를 가져옵니다.
                           let start = contentTextView.offset(from: contentTextView.beginningOfDocument, to: currentLineRange.start)
                           let end = contentTextView.offset(from: contentTextView.beginningOfDocument, to: currentLineRange.end)

                           // 글꼴 두께를 변경할 범위에 적용합니다.
                           let attributedText = NSMutableAttributedString(attributedString: contentTextView.attributedText)

                           var fonts: [String] = []
                           attributedText.enumerateAttribute(.font, in: selectedTextRange, options: []) { (value, range, stop) in
                               if let oldFont = value as? UIFont {
                                   fonts.append(oldFont.fontName)
                               }
                           }
                           
                           let contianBold = fonts.contains(".SFUI-Bold")
                           
                           attributedText.enumerateAttribute(.font, in: selectedTextRange, options: []) { (value, range, stop) in
                               
                               if let oldFont = value as? UIFont {
                                   if contianBold {
                                       // 기존 글자 중 하나라도 bold 속성을 가진 경우, medium로 변경합니다.
                                       let regularFont = UIFont.systemFont(ofSize: oldFont.pointSize, weight: .medium)
                                       attributedText.addAttribute(.font, value: regularFont, range: range)
                                   } else {
                                       // 기존 글자 중 bold 속성이 없으면, bold로 변경합니다.
                                       let boldFont = UIFont.systemFont(ofSize: oldFont.pointSize, weight: fontWeight)
                                       attributedText.addAttribute(.font, value: boldFont, range: range)
                                   }
                               }
                           }

                           // 변경된 속성을 텍스트 뷰에 설정합니다.
                           contentTextView.attributedText = attributedText
                       }
                   }
               }
           }
    }
    
    func addImageInTextView(_ image: UIImage?) {
        if let image = image {
            let maxWidth: CGFloat = 200.0 // 이미지의 최대 가로 너비
            let scaleFactor = maxWidth / image.size.width // 가로 너비에 대한 비율 계산
            let newImageSize = CGSize(width: maxWidth, height: image.size.height * scaleFactor)
            
            // 이미지를 리사이즈
            UIGraphicsBeginImageContextWithOptions(newImageSize, false, 0.0)
            image.draw(in: CGRect(x: 0, y: 0, width: newImageSize.width, height: newImageSize.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // 이미지의 코너를 잘라내기
            let cornerRadius: CGFloat = 10.0 // 코너의 반지름
            UIGraphicsBeginImageContextWithOptions(newImageSize, false, 0.0)
            let clippingPath = UIBezierPath(roundedRect: CGRect(origin: .zero, size: newImageSize), cornerRadius: cornerRadius)
            clippingPath.addClip()
            resizedImage?.draw(in: CGRect(origin: .zero, size: newImageSize))
            let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = roundedImage
            imageAttachment.bounds = CGRect(x: 0, y: 0, width: newImageSize.width, height: newImageSize.height)
            
            let imageString = NSAttributedString(attachment: imageAttachment)
            
            // 기존 NSAttributedString 끝에 이미지를 추가
            let currentNSArr = contentTextView.attributedText ?? .init(string: "")
            
            let mutableAttributedString = NSMutableAttributedString(attributedString: currentNSArr)
            mutableAttributedString.append(imageString)
            
            contentTextView.attributedText = NSAttributedString(attributedString: mutableAttributedString)
        }
    }
    
}

extension RegisterTravelReportVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if isCoverImage {
            if let selectedImage = info[.originalImage] as? UIImage {
                selectedCoverImage = selectedImage
                coverImageView.image = selectedImage
                photoImageView.isHidden = true
                photoLabel.isHidden = true
            }
            isCoverImage = false
        } else {
            if let selectedImage = info[.originalImage] as? UIImage {
                addImageInTextView(selectedImage)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterTravelReportVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // title
        if textView.tag == 0 {
            if titleTextView.text.count == 0 {
                titlePlaceHolderLabel.isHidden = false
            } else {
                titlePlaceHolderLabel.isHidden = true
            }
            
            if titleTextView.text.count <= 30 {
                titleTextCountLabel.text = "\(titleTextView.text.count)"
            } else {
                let text = titleTextView.text ?? ""
                let endIndex = text.index(text.startIndex, offsetBy: 29)
                let truncatedString = String(text[..<endIndex])
                titleTextView.text = truncatedString
            }
        }
        // content
        if textView.tag == 1 {
            if contentTextView.text.count == 0 {
                contentPlaceHolderLabel.isHidden = false
            } else {
                contentPlaceHolderLabel.isHidden = true
            }
            
            if contentTextView.text.count <= 10000 {
                contentCountLabel.text = "\(contentTextView.text.count)"
            } else {
                let text = contentTextView.text ?? ""
                let endIndex = text.index(text.startIndex, offsetBy: 29)
                let truncatedString = String(text[..<endIndex])
                contentTextView.text = truncatedString
            }
        }
    }
}
