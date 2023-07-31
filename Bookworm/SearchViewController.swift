//
//  ViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        
        let xMarkImage = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xMarkImage, style: .plain, target: self, action: #selector(closeBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
    }
    
    @objc
    func closeBarButtonClicked() {
        dismiss(animated: true)
    }


}

