//
//  EditorViewController.swift
//  記帳
//
//  Created by Murphy on 2024/4/9.
//

import UIKit

class EditorViewController: UIViewController {

    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var detailClass: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var remark: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定label可點擊，點擊後出現日期選單(datePicker)
        date.isUserInteractionEnabled = true
        let dateTrigger = UITapGestureRecognizer(target: self, action: #selector(datePicker))
        date.addGestureRecognizer(dateTrigger)
        
        remark.isUserInteractionEnabled = true
        let remarkTrigger = UITapGestureRecognizer(target: self, action: #selector(addRemark))
        remark.addGestureRecognizer(remarkTrigger)
        // Do any additional setup after loading the view.
    }

    /**
        date 標籤點擊後發生的事件
     */
    @objc func datePicker(_ sender: UITapGestureRecognizer){
        print("4/9")
    }
    
    /**
        remark 標籤點擊後發生的事件
     */
    @objc func addRemark(_ sender: UITapGestureRecognizer){
        print("remark")
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
