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

class RegisterTravelReportVC: UIViewController {
    
    private var headerView: UIView!
    private var backButton: UIButton!
    private var registerButton: UIButton!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var footerScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeHeaderView()
        makeCover()
        
        makeFooter()
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
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        scrollView.backgroundColor = .green
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(1000)
        }
        
        let coverContainerView = UIView()
        coverContainerView.backgroundColor = .systemYellow
        
        contentView.addSubview(coverContainerView)
        coverContainerView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.top.leading.equalToSuperview()
            make.height.equalTo(354)
        }
        
        // add more comp
    }
    
    func makeFooter() {
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
        
        let textButton = UIButton()
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
        secondView.backgroundColor = .blue
        footerScrollView.addSubview(secondView)
        secondView.snp.makeConstraints { make in
            make.width.equalTo(footerContainerView.snp.width)
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(actionView.snp.trailing)
            make.trailing.equalToSuperview()
        }
        
    }
}
