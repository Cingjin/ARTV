//
//  CJSetViewController.swift
//  ARTV
//
//  Created by Anmo on 2020/1/22.
//  Copyright © 2020 com.Cingjin. All rights reserved.
//

import UIKit

class CJSetViewController: CJBaseViewController,UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cj_initSelf()
        
    }
    
    private func cj_initSelf() {
        
        self.modalPresentationStyle = UIModalPresentationStyle.popover
        self.popoverPresentationController?.delegate = self
    }

}
