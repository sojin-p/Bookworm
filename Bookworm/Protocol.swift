//
//  Protocol.swift
//  Bookworm
//
//  Created by 박소진 on 2023/08/03.
//

import UIKit

@objc
protocol NavigationUIProtocol {
    var navTitle: String { get set }
    var mainBackColor: UIColor { get }
    
    func setUI()
    @objc optional func setBarButton()
}
