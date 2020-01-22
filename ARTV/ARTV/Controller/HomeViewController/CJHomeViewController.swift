//
//  CJHomeViewController.swift
//  ARTV
//
//  Created by Anmo on 2020/1/22.
//  Copyright © 2020 com.Cingjin. All rights reserved.
//

import UIKit
import ARKit

class CJHomeViewController: CJBaseViewController {

    
    //MARK: - LiftCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cj_homeAddSubView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cj_homeRunSession()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
        
    }
    
    //MARK: - runAction
    
    private func cj_homeRunSession() {
        if !ARConfiguration.isSupported {
            fatalError("ARConfiguration is not supported.")
        }else {
            sceneView.session.run(configuration, options: [ARSession.RunOptions.resetTracking,ARSession.RunOptions.removeExistingAnchors])
        }
    }
    
    //MARK: - View
    private func cj_homeAddSubView () {
        
        self.view.addSubview(sceneView)
        self.view.addSubview(setBtn)
        
    }
    
    //MARK: - 点击事件
        
    @objc func cj_homeSetClick(sender:UIButton){
        let setVC = CJSetViewController()
        setVC.popoverPresentationController?.sourceView = sender
        setVC.popoverPresentationController?.sourceRect = CGRect.init(x: sender.frame.size.width/2, y: sender.frame.size.height + 5, width: 0, height: 0)
        setVC.preferredContentSize = CGSize.init(width: CJSCREEN_WIDTH - 100, height: 250)
        setVC.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        setVC.modalPresentationStyle = UIModalPresentationStyle.popover
        self.present(setVC, animated: true, completion: nil)
    }
    
    
    // MARK: - Lazy
    
    lazy var sceneView:ARSCNView = {
        let sceneView = ARSCNView(frame: self.view.bounds)
        sceneView.delegate = self
//        sceneView.showsStatistics = true
        sceneView.automaticallyUpdatesLighting = true
        return sceneView
    }()
    
    lazy var configuration:ARWorldTrackingConfiguration = {
       let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        return configuration
    }()
    
    lazy var setBtn : UIButton = {
        let setBtn = UIButton.init(type: UIButton.ButtonType.custom)
        setBtn.frame = CGRect.init(x: 16, y: 36, width: 40, height: 40)
        setBtn.setImage(UIImage(named: "icon_set_btn"), for: UIControl.State.normal)
        setBtn.setImage(UIImage(named: "icon_set_btn"), for: UIControl.State.selected)
        setBtn.addTarget(self, action: #selector(cj_homeSetClick), for: UIControl.Event.touchUpInside)
        return  setBtn
    }()
}

extension CJHomeViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
    }
}
