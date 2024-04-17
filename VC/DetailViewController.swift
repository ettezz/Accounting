//
//  DetailViewController.swift
//  記帳
//
//  Created by Murphy on 2024/4/5.
//

import UIKit
import CoreData

//tabbar內每一個ViewController的分頁第一頁，全部都是繼承UIViewController
class DetailViewController: UIViewController {

    @IBOutlet weak var editViewHeight: NSLayoutConstraint!
    @IBOutlet weak var editView: InputView!
    var inputHeight: CGFloat = 0.0
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var buttonMenu: UIButton!
    
    @IBOutlet weak var mask: UIView!
    
    //用來操作core data的常數
    let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var cellData:[CellInfo]?
    var cellDataDetail1:[CellInfoDetail]?
    var cellDataDetail2:[CellInfoDetail]?
    
    var tempTextfield : UITextField?
    
    var showEditViewHeight:CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //做假資料
        initFakeData()
                                                
        
        //設定menu要先設定好,不是在click btn時設定
        initMenuBtn()
        
        
        //設定上方navigation正中間的文字
        self.navigationItem.title = "明細"
        
        tempTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        
        //設定nib用來給tableview cell使用 delegate & dataSource先設定好
        let tableViewNib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        self.detailTableView.register(tableViewNib, forCellReuseIdentifier: "DetailTableViewCell")
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        
        //設定輸入匡的高度
        inputHeight = editView.btnOutsideViewHeight.constant + 80
        mask.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.2)
        editView.setNeedsLayout()
        editView.layoutIfNeeded()

        

  
        //present datapicker viewControl的closure
        editView.presentDatePickerClosure = { [weak self] in
            guard let selfVC = self else { return }
            let datePickerVC = UIStoryboard(name: "DatePickerSB", bundle: nil).instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
            selfVC.present(datePickerVC, animated: true)
            
            //將datapicker取的值放回日期btn的closure
            datePickerVC.returnDate = { [weak self] returnDate in
                guard let selfVC = self else { return }
                if let date = returnDate {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy/MM/dd"
                    selfVC.editView.dateBtn.setTitle(formatter.string(from: date), for: .normal)
                    
                }
            }
        }
        
        //delegate 關editView
        editView.delegate = self
        
        
        
        //closure 關editView
//        editView.closeEditViewClosure = { [weak self] in
//            guard let selfVC = self else { return }
//            if selfVC.editViewHeight.constant != 0 {
//                UIView.animate(withDuration: 0.5) {
//                    selfVC.editViewHeight.constant = 0
//                    selfVC.mask.isHidden = true
//                    selfVC.editView.setNeedsLayout()
//                    selfVC.editView.layoutIfNeeded()
//                } completion: { finish in
//                    selfVC.editView.isHidden = true
//                }
//            }
//        }
    }
    

    
    
    /**
        彈出輸入資料的VC
     */
    @IBAction func showEditor(_ sender: Any) {
        
        if editViewHeight.constant == 0{
            editView.isHidden = false
            UIView.animate(withDuration: 0.1) {
                self.editViewHeight.constant = self.inputHeight
                self.editView.setNeedsLayout()
                self.editView.layoutIfNeeded()
                self.mask.isHidden = false
            }
        }
        
        //       editView.isHidden = false
//        UIView.animate(withDuration: 0.5) {
//            self.editViewHeight.constant = self.showEditViewHeight ?? 0
//            //讓畫面再次重新設置新設定的layout
//            self.editView.setNeedsLayout()
//            self.editView.layoutIfNeeded()
//        }
//        
//        //畫面reload
//        editView.reload()

        //用viewController的做法
//        let editorSB = UIStoryboard(name: "EditorSB", bundle: nil)
//        let editorVC = editorSB.instantiateViewController(identifier: "EditorViewController") as! EditorViewController
//        present(editorVC, animated: true, completion: nil)
        
    }
    
//    func getEditViewHeight() -> CGFloat{
//        editView.calCollectionView.setNeedsLayout()
//        editView.calCollectionView.layoutIfNeeded()
//        //80是其他元件＋間距的高度
//        return editView.calCollectionView.contentSize.height + 80
//    }
    /**
        初始化右上角選單(menu)內容
     */
    func initMenuBtn(){
        buttonMenu.showsMenuAsPrimaryAction = true
        buttonMenu.menu = UIMenu(children: [
                UIAction(title: "記帳", handler: { UIAction in
                    print("記帳")
                }),
                UIAction(title: "收入", handler: { UIAction in
                    print("收入")
                }),
                
                //menu做分段(中間一條灰色)：陣列內放一個UIMenu實體
                UIMenu(options: .displayInline,
                       children: [UIAction(title: "共享帳本", handler: { UIAction in
                           print("共享帳本")
                            })
                                 ]
                      )
            ])
    }
    
    
    func initFakeData(){
        //----init假資料ＳＴＡＲＴ
        let dataDetail1 = CellInfoDetail(item: "餐飲", price: "300")
        let dataDetail2 = CellInfoDetail(item: "餐飲", remark: "聚餐", price: "1200")
        
        let dataDetail3 = CellInfoDetail(item: "交通", price: "120")
        let dataDetail4 = CellInfoDetail(item: "餐飲", remark: "零食", price: "350")
        cellDataDetail1 = [CellInfoDetail]()
        cellDataDetail1?.append(dataDetail1)
        cellDataDetail1?.append(dataDetail2)
        
        cellDataDetail2 = [CellInfoDetail]()
        cellDataDetail2?.append(dataDetail3)
        cellDataDetail2?.append(dataDetail4)
        let data = CellInfo(totalPrice: "1500" ,date: "2024/03/21", detatilData: cellDataDetail1)
        let data2 = CellInfo(totalPrice: "470", date: "2024/04/01", detatilData: cellDataDetail2)
        //init
        cellData = [CellInfo]()
        cellData?.append(data)
        cellData?.append(data2)
        //----init假資料ＥＮＤ
    }
}

/**
    tableView delegate dataSource 相關
 */
extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    //一個section有幾個cell(資料數量)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataDetail1?.count ?? 0
    }
    //cell的內容長什麼樣子
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //設定tableView的cell用指定xib來製作, 須轉型為該xib class  **identifier = cell檔名＆class名
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        //利用indexPath將資料一筆一筆傳入Cell
        if let cellDataDetail = cellData?[indexPath.section].detatilData?[indexPath.row] {
            cell.setCellDetail(cellInfoDetial: cellDataDetail)
        }
        return cell
    }
    //修改section header文字
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return cellData?[section].date
//    }
    
    //tableView內有幾個section
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellData?.count ?? 0
    }
    
    /**
     用UIView當Section
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        //section的view
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 38))
        sectionView.backgroundColor = .white
        
        //設定兩個label
        let dateLabel = UILabel(frame: CGRect(x: 30, y: 0 , width: tableView.frame.width/2, height: 35))
        dateLabel.text = cellData?[section].date
        dateLabel.font = UIFont.boldSystemFont(ofSize: 25)
        dateLabel.textColor = .black
        sectionView.addSubview(dateLabel)
        
        let priceLabel = UILabel(frame: CGRect(x: tableView.frame.width/2, y: 0 , width: tableView.frame.width/2 - 30, height: 35))
        priceLabel.text = cellData?[section].totalPrice
        priceLabel.font = UIFont.boldSystemFont(ofSize: 25)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .right
        sectionView.addSubview(priceLabel)
        
        //section下面的分隔線
        let underLine = UIView(frame: CGRect(x: 15, y: sectionView.frame.height - 1, width: sectionView.frame.width - 30, height: 2))
        underLine.backgroundColor = .lightGray
        sectionView.addSubview(underLine)

        return sectionView
    }
    
    //設定section header的高度（如果用UIView當section，調成跟UIView的高度一樣）
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }

}

extension DetailViewController: InputViewDelegate{
    func closeInputViewKeyboardDelegate() {
        self.view.endEditing(true)
    }
    
    
    func closeInputViewDelegate() {
        if self.editViewHeight.constant != 0 {
            UIView.animate(withDuration: 0.5) {
                self.editViewHeight.constant = 0
                self.editView.setNeedsLayout()
                self.editView.layoutIfNeeded()
            } completion: { finish in
                self.editView.isHidden = true
            }
        }
        self.mask.isHidden = true
    }
    
    
}

