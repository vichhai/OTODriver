//
//  RegisterViewController.swift
//  OTODriver
//
//  Created by iMac007 on 5/22/18.
//  Copyright © 2018 vichhai. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - button action
    
    @IBAction func btnSendClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "verification", sender: nil)
    }
    
}
