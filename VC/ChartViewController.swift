//
//  ChartViewController.swift
//  記帳
//
//  Created by Murphy on 2024/4/5.
//

import UIKit
//tabbar內每一個ViewController的分頁第一頁，全部都是繼承UIViewController
class ChartViewController: UIViewController {


    @IBOutlet weak var viewC: InputView!
    
    
    @IBOutlet weak var viewInput: InputView!
    
    @IBOutlet weak var viewInputHeight: NSLayoutConstraint!
    
    @IBOutlet weak var heightt: NSLayoutConstraint!
    
    var inputHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "圖表"
        
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
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
