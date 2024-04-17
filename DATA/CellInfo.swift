//
//  CellInfo.swift
//  記帳
//
//  Created by Murphy on 2024/4/6.
//

import Foundation

class CellInfo{
    var totalPrice: String?
    var date: String?
    var detatilData: [CellInfoDetail]?
    init(totalPrice: String?, date: String?, detatilData: [CellInfoDetail]?) {
        self.totalPrice = totalPrice
        self.date = date
        self.detatilData = detatilData
    }
}

class CellInfoDetail{
    var item: String?
    var remark: String? = ""
    var price: String?
    
    init(){
        
    }
    
    init(item: String?, remark: String? = "", price: String?) {
        self.item = item
        self.remark = remark
        self.price = price
    }
    
    init(item: String?, price: String?) {
        self.item = item
        self.price = price
    }
}
