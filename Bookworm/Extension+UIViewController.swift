//
//  Extension+UIViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

extension UIViewController {
    func setBackgroundColor() {
        view.backgroundColor = .white
    }
}

extension UILabel {
    func configureTitleText(title: String, fontSize: CGFloat) {
        self.font = .boldSystemFont(ofSize: fontSize)
        self.text = title
    }
}
