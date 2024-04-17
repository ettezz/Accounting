//
//  inputViewTableViewCell.swift
//  記帳
//
//  Created by Murphy on 2024/4/13.
//

import UIKit

class InputViewTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(imgName: String, labelName: String){
        iconImg.image = UIImage(named: imgName)
        itemName.text = labelName
        if labelName == "自訂"{
            itemName.textColor = .link
        }
    }
}
