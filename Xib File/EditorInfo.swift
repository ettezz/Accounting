//
//  EditorInfo.swift
//  記帳
//
//  Created by Murphy on 2024/4/10.
//

import UIKit

class EditorInfo: UIView {
    	
    @IBOutlet weak var currentItemLabel: UILabel!
    
    @IBOutlet weak var calCollectionView: UICollectionView!
    
    @IBOutlet weak var itemPickerView: UIPickerView!
    
    var pickerViewInfo: PickerViewInfo? = PickerViewInfo()
    
    
    let collectionViewBtnInfo = ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ".", "⬅︎"]
    var tmpView: UIView?
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loadXibView(viewName: "EditorInfo")
        setCollectionViewNib()
        setPickerViewDelegate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXibView(viewName: "EditorInfo")
        setCollectionViewNib()
        setPickerViewDelegate()
    }
    
    /**
     set collection view nib
     */
    func setCollectionViewNib(){
        let nib = UINib(nibName: "EditorCollectionViewCell", bundle: nil)
        self.calCollectionView.register(nib, forCellWithReuseIdentifier: "EditorCollectionViewCell")
        calCollectionView.dataSource = self
        calCollectionView.delegate = self
        
        /**
         設定每個collection cell 用autolayout決定大小(強制Size由autolayout決定，不要跟用程式碼設定共同使用 )
         */
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        calCollectionView.collectionViewLayout = flowLayout

    }
    
    /**
     set picker view delegate
     */
    func setPickerViewDelegate(){
        itemPickerView.delegate = self
        itemPickerView.dataSource = self
    }
    /**
     reload畫面
     */
    func reload(){
        loadXibView(viewName: "EditorInfo")
        setCollectionViewNib()
        setPickerViewDelegate()
        
    }
    
    /**
     載入xib畫面
     */
    func loadXibView(viewName:String){
        //每次進來，若原本有xibView的畫面，就刪除畫面（所以第一次不會跑這個if let）
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
     修改日期
     */
    @IBAction func editDate(_ sender: Any) {
        
    }
    
    /**
     填寫備註
     */
    @IBAction func editRemark(_ sender: Any) {
    }
}

/**
 collection view delegate/datasource設定
 */
extension EditorInfo: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewBtnInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditorCollectionViewCell", for: indexPath) as! EditorCollectionViewCell
        cell.setbtnText(text: collectionViewBtnInfo[indexPath.row])
        
        return cell
    }
  
}
/**
 程式碼決定cell的大小
 */
extension EditorInfo: UICollectionViewDelegateFlowLayout{
    //用程式碼決定cell的大小 不要跟UI的autolayout同時使用
    func collectionView( _ collectionView: UICollectionView ,
                         layout collectionViewLayout: UICollectionViewLayout ,
                         sizeForItemAt indexPath: IndexPath ) -> CGSize {
        let widthVal = (collectionView.frame.width - 30 )/3.0
        return CGSize( width: widthVal, height: widthVal )
    }
}

/**
 picker view delegate/datasource設定
 */
extension EditorInfo: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewInfo?.pickerViewShowText?.count ?? 0
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let returnStr = pickerViewShowText?[row]
//        return returnStr
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerCell = UIView(frame: CGRect(x:  0, y: 0, width: pickerView.frame.width, height: 50))
        pickerCell.backgroundColor = .white
        
        let icon = UIImageView(frame: CGRect(x: 10, y: 13, width: 24, height: 24))
        icon.backgroundColor = .white
        pickerCell.addSubview(icon)
        
        let labelFrameWidth = pickerView.frame.width - 34
        let textLabel = UILabel(frame: CGRect(x: 44, y: 13, width: labelFrameWidth, height: 24))
        textLabel.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel.textColor = .black

//        textLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerCell.addSubview(textLabel)
        
//        NSLayoutConstraint.activate([
//            icon.leadingAnchor.constraint(equalTo: pickerCell.leadingAnchor, constant: 100),
//            icon.centerYAnchor.constraint(equalTo: pickerCell.centerYAnchor),
//            textLabel.trailingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 15),
//            textLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor)
//        ])
        
        pickerViewInfo?.setInfo(row: row, label: textLabel, icon: icon)
        
        return pickerCell
    }
    
}
