//
//  CoffeeTableViewCell.swift
//  CoffeeStore
//
//  Created by Quang Kham on 20/05/2020.
//  Copyright © 2020 Quang Kham. All rights reserved.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {

    
    @IBOutlet var photo: UIImageView!

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
