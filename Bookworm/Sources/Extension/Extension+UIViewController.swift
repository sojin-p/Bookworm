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
    func setTitleText(_ title: String, size: CGFloat) {
        self.font = .boldSystemFont(ofSize: size)
        self.text = title
    }
    
    func setSubTitle(_ title: String, size: CGFloat, color: UIColor) {
        self.text = title
        self.font = .systemFont(ofSize: size)
        self.textColor = color
    }
    
    func setLongText(_ title: String, size: CGFloat, color: UIColor, line: Int) {
        self.text = title
        self.font = .systemFont(ofSize: size)
        self.textColor = color
        self.numberOfLines = line
    }
}

extension UIView {
    func setCorner(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setViewShadow(w: CGFloat, h: CGFloat, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: w, height: h) //햇빛 방향(.zero도 사용가능)
        self.layer.shadowRadius = radius //퍼짐의 정도
        self.layer.shadowOpacity = opacity //0~1 사이에서 투명도 조절
        self.clipsToBounds = false
    }
}
