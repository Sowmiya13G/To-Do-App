//
//  ListTableViewCell.swift
//  To Do App
//
//  Created by DB-MM-002 on 04/08/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {

 
    @IBOutlet weak var lblForTask: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
