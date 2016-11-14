//
//  TableViewCell.swift
//  Stretchy Effect
//
//  Created by Arjun Kodur on 11/13/16.
//  Copyright © 2016 Arjun Kodur. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var imageModel: ImageModel? {
        didSet{
            label.text = imageModel?.author
            setupImage()
        }
    }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageview: CustomImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Loading Image
    func setupImage() {
        if let ImageUrl = imageModel?.urlString {
            imageview.loadImageUsingUrlString(ImageUrl)
        }
    }
    

}

