//
//  BookCollectionViewCell.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var backView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    func configureCell(item: Movie) {
        
        titleLabel.configureTitleText(title: item.mainTitle, fontSize: 18)
        rateLabel.text = "\(item.rate)"
        rateLabel.font = .systemFont(ofSize: 13)
        
        backView.backgroundColor = randomBackgroundColor()
        backView.layer.cornerRadius = 15
        
        bookImageView.image = UIImage(named: item.mainTitle)
    }
    
    func randomBackgroundColor() -> UIColor {
        let r = CGFloat.random(in: 0.7...1)
        let g = CGFloat.random(in: 0.7...1)
        let b = CGFloat.random(in: 0.7...1)
        let color = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        return color
    }

}
