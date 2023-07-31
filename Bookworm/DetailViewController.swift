//
//  DetailViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contents = ""
    @IBOutlet var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = contents
        
        let closeButtonImage = UIImage(systemName: "chevron.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: closeButtonImage, target: self, action: #selector(popBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        detailLabel.text = "상세 화면"

    }
    
    @objc
    func popBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
