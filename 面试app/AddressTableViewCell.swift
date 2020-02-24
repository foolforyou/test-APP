//
//  AddressTableViewCell.swift
//  面试app
//
//  Created by 陈思 on 2020/2/24.
//  Copyright © 2020 chance. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    typealias reSetAddress = ()->()
    var reSetAddressBlock : reSetAddress!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBAction func reSetAddress(_ sender: Any) {
        if let _ = reSetAddressBlock{
            reSetAddressBlock();
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
