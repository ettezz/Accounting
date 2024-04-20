//
//  ChartViewController.swift
//  記帳
//
//  Created by Murphy on 2024/4/5.
//

import UIKit
//tabbar內每一個ViewController的分頁第一頁，全部都是繼承UIViewController
class ChartViewController: UIViewController {

    var tableViewShowText:[String]? = ["餐飲","零食","衣服","交通","日用品","化妝品","加油","娛樂","家用","旅行","自訂"]
    @IBOutlet weak var viewC: InputView!
    
    
    @IBOutlet weak var viewInput: InputView!
    
    @IBOutlet weak var viewInputHeight: NSLayoutConstraint!
    
    @IBOutlet weak var heightt: NSLayoutConstraint!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var inputHeight: CGFloat = 0.0
    
    var cantScroll = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "圖表"
        pickerView.delegate = self
        pickerView.dataSource = self
        
//        inputHeight = viewInput.btnOutsideViewHeight.constant + 80
//        print("controller: \(inputHeight)")
//        viewInputHeight.constant = inputHeight
//        viewInput.setNeedsLayout()
//        viewInput.layoutIfNeeded()
        /**用來讓UI畫面馬上重新設置新設定的layout
            viewC.calCollectionView.setNeedsLayout()
            viewC.calCollectionView.layoutIfNeeded()
         */
//        viewC.calCollectionView.setNeedsLayout()
//        viewC.calCollectionView.layoutIfNeeded()
        
        //取得實際collection view內cell的高度
//        var h = viewC.calCollectionView.contentSize.height
        
        //80是其他元件＋間距的高度
//        heightt.constant = h + 80
        
        //讓畫面再次重新設置新設定的layout
//        self.viewC.setNeedsLayout()
//        self.viewC.layoutIfNeeded()

        //畫面reload
//        viewC.reload()
        // Do any additional setup after loading the view.
    }


}

extension ChartViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(cantScroll){
            return (tableViewShowText?.count ?? 0) - 1
        }
        
        return tableViewShowText?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tableViewShowText?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let lastIndex = tableViewShowText?.count{
            if(row == lastIndex - 1){
                cantScroll = true
                pickerView.reloadAllComponents()
//                pickerView.selectRow(lastIndex - 2, inComponent: 0, animated: false)
            }
        }
        
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//        view.backgroundColor = .yellow
//        let label = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width/2)-25, y: 10, width: 50, height: 20))
//        label.text = tableViewShowText?[row]
//        label.textColor = .black
//        view.addSubview(label)
//        
//        return view
//    }
}
