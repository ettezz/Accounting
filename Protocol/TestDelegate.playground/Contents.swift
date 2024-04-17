import UIKit

protocol FeedDelegate: AnyObject {
    
    func feeding(_ : String)
    
}

class Owner{
    
    weak var delegate: FeedDelegate?

    func feedingDryFood(){
        self.delegate?.feeding("卡滋卡滋的乾乾")
    }

    func feedingCannedFood(){
        self.delegate?.feeding("香噴噴的罐罐")
    }
}
class AutoFeeder: FeedDelegate{
    
    let murphy = Owner()
    
    func setDelegate(){
        murphy.delegate = self
    }

    //實作feeding任務的內容
    func feeding(_ food: String) {
        print("自動餵食機正在餵食．．．")
        print("貓貓這餐吃\(food)")
    }
}

class FamilyMember: FeedDelegate{
    
    let murphy = Owner()
    
    func setDelegate(){
        murphy.delegate = self
    }

    //實作feeding任務的內容
    func feeding(_ food: String) {
        print("家人正在餵食．．．")
        print("貓貓這餐吃\(food)")
    }
}

let autoFeeder = AutoFeeder()
autoFeeder.setDelegate()
//餵食機，我通知你餵貓貓吃乾乾囉！
autoFeeder.murphy.feedingDryFood()
print()
let dante = FamilyMember()
dante.setDelegate()
//親愛的，我通知你餵貓貓吃乾乾囉！
dante.murphy.feedingDryFood()
print()
//親愛的，我通知你餵貓貓吃罐罐囉！
dante.murphy.feedingCannedFood()
