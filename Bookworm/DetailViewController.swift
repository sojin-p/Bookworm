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
        titleLabel.setTitleText(contents.mainTitle, size: 20)
        
        releaseDateLabel.setSubTitle(contents.subTitle, size: 13, color: .gray)
        
        rateLabel.setSubTitle(contents.rateString, size: 16, color: .gray)
        
        overviewLabel.setLongText(contents.overview, size: 14, color: .black, line: 7)
        
        posterImageView.image = UIImage(named: contents.mainTitle)
        posterImageView.setCorner(20)
        
        detailBackView.setCorner(20)
        detailBackView.setViewShadow(w: 5, h: 5, radius: 5, opacity: 0.5)
        
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
