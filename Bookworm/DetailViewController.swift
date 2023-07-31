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
        detailLabel.text = "상세 화면"

    }
    

}
