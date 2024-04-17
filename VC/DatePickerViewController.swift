//
//  DatePickerViewController.swift
//  記帳
//
//  Created by Murphy on 2024/4/14.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var returnDate: ( _ : Date?)->() = { _ in  }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = UIColor(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1)
        datePicker.backgroundColor = .white
        // Do any additional setup after loading the view.
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
    }
    
    @objc func dateChanged(){
        returnDate(datePicker.date)
        dismiss(animated: true)
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
