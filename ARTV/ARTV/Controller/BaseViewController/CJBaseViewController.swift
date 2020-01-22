//
//  CJBaseViewController.swift
//  ARTV
//
//  Created by Anmo on 2020/1/22.
//  Copyright © 2020 com.Cingjin. All rights reserved.
//

import UIKit

class CJBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cj_baseSet()
        
    }
    
    private func cj_baseSet() {
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
}
