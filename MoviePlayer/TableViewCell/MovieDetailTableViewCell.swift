//
//  MoviewDetailTableViewCell.swift
//  MoviePlayer
//
//  Created by Devkrushna4 on 13/08/22.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame.size.height = lblDetails.optimalHeight
//        lblDetails.adjustsFontSizeToFitWidth = true
//        lblDetails.frame.size.height = lblDetails.optimalHeight
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

import UIKit

extension UILabel {
    var optimalHeight : CGFloat {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
        
    }
}
