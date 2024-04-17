//
//  InputView.swift
//  記帳
//
//  Created by Murphy on 2024/4/13.
//

import UIKit

class InputView: UIView {

    @IBOutlet weak var itemImg: UIImageView!
    
    @IBOutlet weak var display: UIView!
    
    @IBOutlet weak var displayHeight: NSLayoutConstraint!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var remarkTextfield: UITextField!
    
    @IBOutlet weak var remarkTextFieldHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topBorderView: UIView!
    
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var btnOutsideViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnView: UIView!
    
    @IBOutlet weak var dateBtn: UIButton!
    
    @IBOutlet weak var itemTableView: UITableView!

    @IBOutlet var btnCollection: [UIButton]!
    
    var tmpView: UIView?

    var presentDatePickerClosure: ()->() = {}
    
    var closeEditViewClosure: ()->() = {}

    weak var delegate: InputViewDelegate?
    
    
    
    var tableViewShowText:[String]? = ["餐飲","零食","衣服","交通","日用品","化妝品","加油","娛樂","家用","旅行","自訂"]
    var tableViewHideText:[String]? = ["社交","購物","運動","醫療","禮物","小孩","寵物"]
    var showIconImg:[String]? = ["restaurant", "candy","polo-shirt","bus","box","cosmetic","car","microphone","home","airplane","tools"]
    var hideIconImg:[String] = ["friend","cart","woman-biking","doctors-bag","present","kid","pet"]
    
    /**
     load XIB畫面固定程式碼，UI設定都要在loadXibView之後才能做
     */
    override init(frame: CGRect){
        super.init(frame: frame)
        loadXibView(viewName: "InputView")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXibView(viewName: "InputView")
        display.layer.cornerRadius = display.frame.height / 2
        btnOutsideViewHeight.constant = UIScreen.main.bounds.height * 0.3
        btnView.setNeedsLayout()
        btnView.layoutIfNeeded()
        setTableViewNib()
        setBtnFrame()
        
        //dateLabel預設今天日期
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        //btn修改文字內容要用setTitle(預設定之文字, .normal)
        dateBtn.setTitle(formatter.string(from: date), for: .normal)
        remarkTextFieldHeight.constant = (display.frame.height-0.5) * 0.45
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeView(_:)))
        swipeGesture.direction = .down
        topBorderView.addGestureRecognizer(swipeGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboardObjc(_:)))
        
      
    }
    @objc func closeView(_ gesture: UITapGestureRecognizer) {
        //closure寫法
        //self.closeEditViewClosure()
        
        
        //delegate寫法
        self.delegate?.closeInputViewDelegate()
    }
    
    @objc func closeKeyboardObjc(_ gesture: UITapGestureRecognizer){
        
        self.delegate?.closeInputViewDelegate()
        
    }
    
    @IBAction func closeKeyboard(_ sender: Any) {
        topBorderView.endEditing(true)
    }
    
    func loadXibView(viewName: String){
        if let sub = self.tmpView{
            sub.removeFromSuperview()
        }
        
        //將xib畫面帶入欲顯示的地方（固定code)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: viewName, bundle: bundle)
        let xibView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        xibView.frame = bounds
        self.frame = bounds
        self.addSubview(xibView)
        
        //把已添加的xib畫面暫存起來，若之後需修改則先刪處畫面再重新帶入
        self.tmpView = xibView
    }
    
    
    /**
        設定tableViewNib
     */
    func setTableViewNib(){
        let tableViewNib = UINib(nibName: "InputViewTableViewCell", bundle: nil)
        self.itemTableView.register(tableViewNib, forCellReuseIdentifier: "InputViewTableViewCell")
        itemTableView.delegate = self
        itemTableView.dataSource = self
    }
    
    @IBAction func changeDate(_ sender: Any) {
        self.presentDatePickerClosure()
    }

    /**
        將按鈕導圓角
     */
    func setBtnFrame(){
        for btn in btnCollection{
            btn.layer.cornerRadius = btn.frame.height / 2
        }
    }
    
    @IBAction func numberBtnAction(_ sender: UIButton) {
        let priceLabel = self.price.text ?? "0"
        if(priceLabel.count == 17){
            return
        }
        
        if let btnText = sender.titleLabel?.text{            if(self.validatePriceFormat()){
                switch(btnText){
                case "1":
                    self.price.text = priceLabel + btnText
                case "2":
                    self.price.text = priceLabel + btnText
                case "3":
                    self.price.text = priceLabel + btnText
                case "4":
                    self.price.text = priceLabel + btnText
                case "5":
                    self.price.text = priceLabel + btnText
                case "6":
                    self.price.text = priceLabel + btnText
                case "7":
                    self.price.text = priceLabel + btnText
                case "8":
                    self.price.text = priceLabel + btnText
                case "9":
                    self.price.text = priceLabel + btnText
                case "0":
                    self.price.text = priceLabel + btnText
                default: return
                }
            }
            else{
                self.price.text = btnText
            }
        }
    }
    
    /**
        判斷price數字格式是否合法
        true:price當下文字不為０
        false: price當下文字為０
     */
    func validatePriceFormat() -> Bool{
        let priceLabel = price.text ?? "0"
        if(priceLabel.count == 1 && priceLabel == "0"){
            return false
        }
        else{
            return true
        }
    }
    
    @IBAction func undoPrice(_ sender: Any) {
        var priceLabel = self.price.text ?? "0"
        if (priceLabel.count > 1 ){
            priceLabel.removeLast()
            self.price.text = priceLabel
        }
        else{
            self.price.text = "0"
        }
        
    }
    
}

/**
    UITableView delegate / dataSource
 */
extension InputView: UITableViewDelegate, UITableViewDataSource{
    /**
      return 一個section中欄位的數量
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewShowText?.count ?? 0
    }
    
    /**
        return cell樣式
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputViewTableViewCell", for: indexPath) as! InputViewTableViewCell
        if let iconName = showIconImg?[indexPath.row], 
            let labelName = tableViewShowText?[indexPath.row]{
            cell.setCell(imgName: iconName, labelName: labelName)
        }
        
        return cell
    }

}


