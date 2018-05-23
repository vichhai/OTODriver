//
//  VerificationViewController.swift
//  OTODriver
//
//  Created by iMac007 on 5/22/18.
//  Copyright © 2018 vichhai. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController {

    // outlet
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var textFieldCollection: [UITextField]!
    
    
    // properties
    var timer : Timer!
    var poseDuration = 60.0
    var indexProgressBar = 0.0
    var verificationStr = ""
    
    lazy var dumpTextField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.delegate = self
        textField.becomeFirstResponder()
        return textField
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(dumpTextField)
        
        doProgress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // show navigation bar
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Custom methods
    private func doProgress() {
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(setProgressBar), userInfo: nil, repeats: true)
    }
    
    @objc private func setProgressBar() {
        if indexProgressBar == poseDuration {
            // reset the timer
            timer.invalidate()
            
            // mark show some alert
        }
        
        DispatchQueue.main.async {
            // update the display
            // use poseDuration - 0.1 so that you display 60 steps of the the progress bar, from 0...59
            self.progressView.progress = Float(self.indexProgressBar / self.poseDuration)
            
            // increment the counter
            self.indexProgressBar += 0.1
        }
    }
    
    private func setTextWhenPressBackSpace() {
        verificationStr.removeLast()
        print(verificationStr)
        
        let strArr = stringToArrayOfString(anyString: verificationStr)
        let count = strArr.count
    
        if count == 0 {
            textFieldCollection.forEach{ $0.text = "" }
        } else {
            textFieldCollection[count].text = ""
        }
    }
    
    private func stringToArrayOfString(anyString : String) -> [String] {
        
        let charArr = Array(anyString)
        let strArr = charArr.map {
            return String($0)
        }
        return strArr
    }
}

extension VerificationViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let length = (textField.text?.utf16.count)! + string.utf16.count - range.length
        
        if length <= 3 {
            
            // get backspace
            let  char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            
            if isBackSpace == -92 { // if backspace
                setTextWhenPressBackSpace()
            } else {
                verificationStr += string
                let strArr = stringToArrayOfString(anyString: verificationStr)
                let count = strArr.count
                textFieldCollection[count - 1].text = strArr[count - 1]
            }
        }
        return length <= 3
    }
}
