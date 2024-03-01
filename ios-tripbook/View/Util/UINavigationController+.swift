//
//  UINavigationController+.swift
//  ios-tripbook
//
//  Created by 이시원 on 3/1/24.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
