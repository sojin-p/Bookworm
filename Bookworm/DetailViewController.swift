//
//  DetailViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var data: Movie?
    
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
        
        guard let data else { return }
        
        title = data.mainTitle
        titleLabel.setTitleText(data.mainTitle, size: 20)

        releaseDateLabel.setSubTitle(data.subTitle, size: 13, color: .gray)

        rateLabel.setSubTitle(data.rateString, size: 16, color: .gray)

        overviewLabel.setLongText(data.overview, size: 14, color: .black, line: 7)

        posterImageView.image = UIImage(named: data.mainTitle)
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
