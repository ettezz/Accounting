//
//  EditorCollectionViewCell.swift
//  記帳
//
//  Created by Murphy on 2024/4/10.
//

import UIKit

class EditorCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setbtnText(text: String){
        labelText.text = text
        
        //調整label字體大小
        labelText.font = labelText.font.withSize(40)
    }

}
