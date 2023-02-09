//
//  NowPlayingTableViewCell.swift
//  LatihanMengunduhGambar
//
//  Created by Ade Fajr Ariav on 09/02/23.
//

import UIKit

class NowPlayingTableViewCell: UITableViewCell {

    @IBOutlet var ivPoster: UIImageView!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    @IBOutlet var lblJudul: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
