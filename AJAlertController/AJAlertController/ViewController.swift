//
//  ViewController.swift
//  AJCustomAlert
//
//  Created by Arpit Jain on 13/12/17.
//  Copyright © 2017 Arpit Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showAlertWithVC(){
        AJAlertController.initialization().showAlert(aStrMessage: "This is Alert message with two buttons", aCancelBtnTitle: "NO", aOtherBtnTitle: "YES") { (index, title) in
            print(index,title)
        }
    }
    
    func showAlertWithOkButton(){
        AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "This is normal alert message") { (index, title) in
             print(index,title)
        }
    }
    
    @IBAction func btnShowAlert(_ sender: UIButton) {
        showAlertWithVC()
    }
    
    @IBAction func btnNormalAlert(_ sender: UIButton) {
        showAlertWithOkButton()
    }
}

