//
//  MovieTableViewCell.swift
//  LatihanMengunduhGambar
//
//  Created by Ade Fajr Ariav on 06/02/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
