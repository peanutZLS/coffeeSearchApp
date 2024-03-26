//
//  CoffeeTableViewCell.swift
//  coffeeAPP
//
//  Created by 郭家宇 on 2024/3/26.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var coffeeAddress: UILabel!
    @IBOutlet weak var coffeeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
