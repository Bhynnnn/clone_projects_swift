//
//  ProductViewController.swift
//  [Project 1] GoodAsOldPhones
//
//  Created by 강보현 on 2022/08/10.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var IVProduct: UIImageView!
    
    @IBOutlet weak var LBPhoneName: UILabel!
    
    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        LBPhoneName.text = product?.name

        if let imageName = product?.fullscreenImageName {
            IVProduct.image = UIImage(named: imageName)
        }
    }
    
    @IBAction func addToCartButtonDidTap(_ sender: AnyObject){
        print("Add to cart successfully")
    }

}
