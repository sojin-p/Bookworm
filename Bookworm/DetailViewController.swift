//
//  DetailViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

struct Contents {
    
    var mainTitle: String = ""
    var releaseDate: String = ""
    var runtime: Int = 0
    var rate: Float = 0
    var overview: String = ""
    
    var subTitle: String {
        get {
            return "\(releaseDate) | \(runtime)분"
        }
    }
    
    var rateString: String {
        "\(rate)점"
    }
    
}


class DetailViewController: UIViewController {
    
    var contents = Contents()
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var detailBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBasic()
        setBackButton()

    }
    
    func setBasic() {
        title = contents.mainTitle
        titleLabel.text = contents.mainTitle
        releaseDateLabel.text = contents.subTitle
        rateLabel.text = contents.rateString
        overviewLabel.text = contents.overview
        posterImageView.image = UIImage(named: contents.mainTitle)
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
