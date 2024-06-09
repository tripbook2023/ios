//
//  UINavigationController+.swift
//  ios-tripbook
//
//  Created by 이시원 on 3/1/24.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
  open override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
