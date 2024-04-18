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
    
    var keyboardToolBarTextlabel:UILabel?
    
    var swipeGesture:UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    
    var swipeGestureActive: Bool = true
    
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
        setTableViewNib()
        setUIFrames()
        setKeyboardToolBar()
        setCloseEditView()

    }
    
    
    
    
     /**
        將editView下縮
     */
    func setCloseEditView(){
        self.swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(setCloseEditViewObjc(_:)))
        swipeGesture.direction = .down
        topBorderView.addGestureRecognizer(swipeGesture)
    }
    @objc func setCloseEditViewObjc(_ gesture: UITapGestureRecognizer) {
        guard swipeGestureActive else { return }
        self.price.text = "0"
        self.remarkTextfield.text = ""
        //closure寫法
        self.closeEditViewClosure()
        
        
        //delegate寫法
        //self.delegate?.closeInputViewDelegate()
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
        設定輸入備註時的小鍵盤上方功能列
     */
    func setKeyboardToolBar(){
        let screenWidth = UIScreen.main.bounds.width
        
        //小鍵盤上方的toolBar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
        toolBar.backgroundColor = .gray
        
        //清除按鈕
        let cleanKeyboardButton = UIBarButtonItem(title: "clean", style: .plain, target: self, action: #selector(cleanEditText))
        
        //顯示編輯的View
        let displayView = UIView(frame: CGRect(x: 0, y: 2, width: screenWidth * 0.75, height: 30))
        displayView.layer.cornerRadius = 15
        displayView.backgroundColor = .white
        //設定View裡面顯示的label
        self.keyboardToolBarTextlabel = UILabel(frame: CGRect(x: 10, y: 2, width: screenWidth * 0.75 - 20, height: 28))
        self.keyboardToolBarTextlabel?.textColor = .black
        self.keyboardToolBarTextlabel?.text = ""
        displayView.addSubview(keyboardToolBarTextlabel ?? UILabel())
        let toolBarView = UIBarButtonItem(customView: displayView)
        
        //監聽remarkTextfield,當文字改變時toolBar工具裡的文字也要改變
        remarkTextfield.addTarget(self, action: #selector(changeTextOnToolbar), for: .editingChanged)
        
        //元件之間的空白，會自動調整寬度
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //用陣列排序元件
        toolBar.items = [flexSpace, toolBarView, cleanKeyboardButton]
        toolBar.sizeToFit()
        self.remarkTextfield.inputAccessoryView = toolBar
    }
    /**
        清除畫面文字
     */
    @objc func cleanEditText(_ sender: Any) {
        self.keyboardToolBarTextlabel?.text = ""
        remarkTextfield.text = ""
    }
    /**
        備註欄位植被變更時螢幕小鍵盤上面的文字也要被變更
        判斷最大值20字
     */
    @objc func changeTextOnToolbar(){
        if var textFieldText = remarkTextfield.text{
            if(textFieldText.count <= 20){
                self.keyboardToolBarTextlabel?.text = textFieldText
            }
            else{
                remarkTextfield.text = String(textFieldText.prefix(20))
                self.keyboardToolBarTextlabel?.text = String(textFieldText.prefix(20))
            }
        }
        
    }
    
    
    /**
        設定tableViewNib/delegate
     */
    func setTableViewNib(){
        let tableViewNib = UINib(nibName: "InputViewTableViewCell", bundle: nil)
        self.itemTableView.register(tableViewNib, forCellReuseIdentifier: "InputViewTableViewCell")
        itemTableView.delegate = self
        itemTableView.dataSource = self
        remarkTextfield.delegate = self
    }
    
    
    
    /**
        變更日期
     */
    @IBAction func changeDate(_ sender: Any) {
        self.presentDatePickerClosure()
    }

    
    
    /**
        設定畫面內Frame設定
     */
    func setUIFrames(){
        //display導圓角
        self.display.layer.cornerRadius = display.frame.height / 2
       
        //數字區btn導圓角
        for btn in btnCollection{
            btn.layer.cornerRadius = btn.frame.height / 2
        }
        
        //數字區高度
        self.btnOutsideViewHeight.constant = UIScreen.main.bounds.height * 0.3
        self.btnView.setNeedsLayout()
        self.btnView.layoutIfNeeded()
        
        //dateLabel預設今天日期
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        //btn修改文字內容要用setTitle(預設定之文字, .normal)
        dateBtn.setTitle(formatter.string(from: date), for: .normal)
        
        //設定備註textField高度
        remarkTextFieldHeight.constant = (display.frame.height-0.5) * 0.45
    }
    
    
    
    /**
        按數字按鈕修改price
     */
    @IBAction func numberBtnAction(_ sender: UIButton) {
        let priceLabel = self.price.text ?? "0"
        if(priceLabel.count == 17){
            return
        }
        
        if let btnText = sender.titleLabel?.text{            
            if(self.validatePriceFormat()){
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
    
    
    
    /**
        btn回退鍵
     */
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



/** extension
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


/** extension
    UITextFieldDelegate
 */
extension InputView: UITextFieldDelegate{
    //在使用者按下 Return 鍵時被呼叫
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 收起鍵盤
        swipeGestureActive = true
        return true
    }
    
    //在使用者開始編輯文字欄位之前被呼叫
    func textFieldDidBeginEditing(_ textField: UITextField) {
        swipeGestureActive = false
    }
}

