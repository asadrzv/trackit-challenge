//
//  PackageCell.swift
//  trackit-challenge
//
//  Created by Asad Rizvi on 3/17/22.
//

import UIKit

class PackageCell: UITableViewCell {
    
    @IBOutlet weak var packageDescriptionLabel: UILabel!
    @IBOutlet weak var trackingNumberLabel: UILabel!
    
    @IBOutlet weak var deliveryStatusLabel: UILabel!
    @IBOutlet weak var deliveryStatusImageView: UIImageView!
    
    @IBOutlet weak var carrierImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
