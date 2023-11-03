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
        //
    }
}

class RegisterTravelReportVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = UITextView()
        textView.text = "aa"
        view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func buttonAction(sender: UIButton!) {
        print("버튼이 클릭되었습니다.")
    }
}
