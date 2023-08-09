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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        rateLabel.font = .systemFont(ofSize: 12)
        rateLabel.textColor = .gray
        
        backView.setCorner(12)
        backView.setViewShadow(w: 2, h: 2, radius: 2, opacity: 0.5)
        
        bookImageView.setCorner(12)
        bookImageView.contentMode = .scaleToFill
        
//        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .systemPink
        
    }
    
    func configureCell(item: Movie) {
        
        titleLabel.text = item.mainTitle
        rateLabel.text = String(item.rate)
        bookImageView.image = UIImage(named: item.mainTitle)
        likeButton(item: item)
        
//        backView.backgroundColor = randomBackgroundColor()
        
    }
    
    func likeButton(item: Movie) {

        if item.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
//    func randomBackgroundColor() -> UIColor {
//        let r = CGFloat.random(in: 0.7...1)
//        let g = CGFloat.random(in: 0.7...1)
//        let b = CGFloat.random(in: 0.7...1)
//        let color = UIColor(red: r, green: g, blue: b, alpha: 1)
//        
//        return color
//    }

}
