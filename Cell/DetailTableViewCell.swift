//
//  detailTableViewCell.swift
//  記帳
//
//  Created by Murphy on 2024/4/6.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var itemWithRemark: UILabel!
    
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var remark: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var itemView: UIView!
    
    @IBOutlet weak var itemRemarkView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCellDetail(cellInfoDetial: CellInfoDetail){
        if let remarkText = cellInfoDetial.remark{
            if(remarkText.isEmpty){
                self.itemRemarkView.isHidden = true
                self.itemView.isHidden = false
                self.item.text = cellInfoDetial.item
            }
            else{
                self.itemView.isHidden = true
                self.itemRemarkView.isHidden = false
                self.itemWithRemark.text = cellInfoDetial.item
                self.remark.text = remarkText
            }
        }
        if let price = cellInfoDetial.price{
            self.price.text = String(price)
        }
        
    }
    
}

