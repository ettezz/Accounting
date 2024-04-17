//
//  MainViewController.swift
//  記帳
//
//  Created by Murphy on 2024/4/5.
//

import UIKit
//進入點的TabbarController
class TabBarInitViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //抓StoryBoard
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let chartSB = UIStoryboard(name: "ChartSB", bundle: nil)
        //抓ViewController
        let detailVC = mainSB.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let chartVC = chartSB.instantiateViewController(withIdentifier: "ChartViewController") as! ChartViewController
        //設定Navigation
        let detailNAV = UINavigationController.init(rootViewController: detailVC)
        let chartNAV = UINavigationController.init(rootViewController: chartVC)
        //設定下方tabbar item的圖案跟文字
        detailNAV.tabBarItem = UITabBarItem(title: "明細", image: UIImage(named: "detail"), selectedImage: UIImage(named: "detail"))
        chartNAV.tabBarItem = UITabBarItem(title: "圖表", image: UIImage(named: "chart"), selectedImage: UIImage(named: "chart"))
        //加入tab bar Controller
        self.addChild(detailNAV)
        self.addChild(chartNAV)
        
        
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
