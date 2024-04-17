//
//  PickerViewInfo.swift
//  記帳
//
//  Created by Murphy on 2024/4/12.
//

import UIKit

class PickerViewInfo: NSObject {
    var textLabel: UILabel?
    var icon: UIImage?
    var pickerViewShowText:[String]? = ["餐飲","零食","衣服","交通","日用品","化妝品","加油","娛樂","家用","旅行","自訂"]
    var pickerViewHideText:[String]? = ["社交","購物","運動","醫療","禮物","小孩","寵物"]
    var showIconImg:[String]? = ["restaurant", "candy","polo-shirt","bus","box","cosmetic","car","microphone","home","airplane","tools"]
    var hideIconImg:[String] = ["friend","cart","woman-biking","doctors-bag","present","kid","pet"]
    
    func setInfo(row: Int, label: UILabel, icon:UIImageView){
        label.text = pickerViewShowText?[row]
        
        if let imgName = showIconImg?[row]{
            let image = UIImage(named: imgName)
            icon.image = image
        }
        else{
            icon.image = UIImage(named: "")
        }
        
        
        
    }
}
