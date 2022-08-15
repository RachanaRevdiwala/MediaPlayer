//
//  TableViewCell.swift
//  MoviePlayer
//
//  Created by Devkrushna4 on 13/08/22.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewMovies: UIImageView!
    @IBOutlet weak var lblMovietitle: UILabel!
    @IBOutlet weak var lblMovieStarRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
