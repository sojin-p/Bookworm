//
//  DetailViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contents: [String] = ["mainTitle", "releaseDate", "runtime", "rate", "overview"]
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var detailBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = contents[0]
        titleLabel.text = contents[0]
        releaseDateLabel.text = "\(contents[1]) | \(contents[2])분"
        rateLabel.text = contents[3]
        overviewLabel.text = contents[4]
        posterImageView.image = UIImage(named: contents[0])
        
        setBackButton()

    }
    
    func setBackButton() {
        let backButtonImage = UIImage(systemName: "chevron.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: backButtonImage, target: self, action: #selector(backBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func backBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
