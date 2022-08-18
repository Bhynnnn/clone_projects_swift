//
//  ContactViewController.swift
//  [Project 1] GoodAsOldPhones
//
//  Created by 강보현 on 2022/08/10.
//

import UIKit

class ContactViewController: UIViewController {
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      
      if #available(iOS 11.0, *) {
        scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
      } else {
        scrollView.frame = CGRect(x: 0, y: topLayoutGuide.length, width: view.frame.width, height: view.frame.height - topLayoutGuide.length - bottomLayoutGuide.length)
      }
      
      scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
    }

}
