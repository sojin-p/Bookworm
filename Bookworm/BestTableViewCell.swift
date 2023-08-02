//
//  BestTableViewCell.swift
//  Bookworm
//
//  Created by 박소진 on 2023/08/02.
//

import UIKit

class BestTableViewCell: UITableViewCell {
    
    @IBOutlet var bestImageView: UIImageView!
    @IBOutlet var bestTitleLabel: UILabel!
    @IBOutlet var bestSubTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
