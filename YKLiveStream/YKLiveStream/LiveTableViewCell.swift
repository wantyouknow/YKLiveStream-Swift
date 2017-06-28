//
//  LiveTableViewCell.swift
//  YKLiveStream
//
//  Created by 裴塔塔 on 5/1/16.
//  Copyright © 2017 peitata. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {
    @IBOutlet weak var imgpor: UIImageView!
    
    @IBOutlet weak var labelnick: UILabel!
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var numbers: UILabel!
    
    @IBOutlet weak var bigimg: UIImageView!
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
