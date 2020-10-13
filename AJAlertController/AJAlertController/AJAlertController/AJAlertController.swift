//
//  AJAlertController.Swift
//  AJAlertController
//
//  Created by Arpit Jain on 13/12/17.
//  Copyright © 2017 Arpit Jain. All rights reserved.
//

import UIKit
import Foundation

class AJAlertController: UIViewController {
    
    // MARK:- Private Properties
    // MARK:-

    private var strAlertTitle = "APPLICATION NAME"
    private var strAlertText = String()
    private var btnCancelTitle:String?
    private var btnOtherTitle:String?
    
    private let btnOtherColor  = UIColor.systemBlue
    private let btnCancelColor = UIColor.systemRed
    
    // MARK:- Public Properties
    // MARK:-

    @IBOutlet var viewAlert: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblAlertText: UILabel?
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnOther: UIButton!
    @IBOutlet var btnOK: UIButton!
    @IBOutlet var viewAlertBtns: UIView!
    @IBOutlet var alertWidthConstraint: NSLayoutConstraint!
    
    /// AlertController Completion handler
    typealias alertCompletionBlock = ((Int, String) -> Void)?
    private var block : alertCompletionBlock?
    
    // MARK:- AJAlertController Initialization
    // MARK:-
    
    /**
     Creates a instance for using AJAlertController
     - returns: AJAlertController
     */
    static func initialization() -> AJAlertController {
        let alertController = AJAlertController(nibName: "AJAlertController", bundle: nil)
        return alertController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAJAlertController()
    }
    
    // MARK:- AJAlertController Private Functions
    // MARK:-
    
    /// Inital View Setup
    private func setupAJAlertController() {
        
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.alpha = 0.8
        visualEffectView.frame = self.view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped)))
        self.view.insertSubview(visualEffectView, at: 0)
        
        preferredAlertWidth()
        
        viewAlert.layer.cornerRadius  = 4.0
        viewAlert.layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
        viewAlert.layer.shadowColor   = UIColor(white: 0.0, alpha: 1.0).cgColor
        viewAlert.layer.shadowOpacity = 0.3
        viewAlert.layer.shadowRadius  = 3.0
       
        lblTitle.text   = strAlertTitle
        lblAlertText?.text   = strAlertText
        
        if let aCancelTitle = btnCancelTitle {
            btnCancel.setTitle(aCancelTitle, for: .normal)
            btnOK.setTitle(nil, for: .normal)
            btnCancel.setTitleColor(btnCancelColor, for: .normal)
        } else {
            btnCancel.isHidden  = true
        }
        
        if let aOtherTitle = btnOtherTitle {
            btnOther.setTitle(aOtherTitle, for: .normal)
            btnOK.setTitle(nil, for: .normal)
            btnOther.setTitleColor(btnOtherColor, for: .normal)
        } else {
            btnOther.isHidden  = true
        }
        
        if btnOK.title(for: .normal) != nil {
            btnOK.setTitleColor(btnOtherColor, for: .normal)
        } else {
            btnOK.isHidden  = true
        }
    }
    
    /// Setup different widths for iPad and iPhone
    private func preferredAlertWidth() {
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                alertWidthConstraint.constant = 280.0
            case .pad:
                alertWidthConstraint.constant = 340.0
            case .unspecified: break
            case .tv: break
            case .carPlay: break
            case .mac: break
        @unknown default:break
        }
    }
    
    /// Create and Configure Alert Controller
    private func configure(message:String, btnCancelTitle:String?, btnOtherTitle:String?) {
        self.strAlertText          = message
        self.btnCancelTitle     = btnCancelTitle
        self.btnOtherTitle    = btnOtherTitle
    }
    
    /// Show Alert Controller
    private func show() {
        if let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window, let rootViewController = window?.rootViewController {
            
            var topViewController = rootViewController
            while topViewController.presentedViewController != nil {
                topViewController = topViewController.presentedViewController!
            }
            
            topViewController.addChild(self)
            topViewController.view.addSubview(view)
            viewWillAppear(true)
            didMove(toParent: topViewController)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.alpha = 0.0
            view.frame = topViewController.view.bounds
            
            viewAlert.alpha     = 0.0
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.view.alpha = 1.0
            }, completion: nil)
            
            viewAlert.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-10)
            UIView.animate(withDuration: 0.2 , delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
                self.viewAlert.alpha = 1.0
                self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0))
            }, completion: nil)
        }
    }
    
    /// Hide Alert Controller
    private func hide() {
        self.view.endEditing(true)
        self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.viewAlert.alpha = 0.0
            self.viewAlert.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-5)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseIn, animations: { () -> Void in
            self.view.alpha = 0.0
            
        }) { (completed) -> Void in
            
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    // MARK:- UIButton Clicks
    // MARK:-
    
    @IBAction func btnCancelTapped(sender: UIButton) {
        block!!(0,btnCancelTitle!)
        hide()
    }
    
    @IBAction func btnOtherTapped(sender: UIButton) {
        block!!(1,btnOtherTitle!)
        hide()
    }
    
    @IBAction func btnOkTapped(sender: UIButton) {
        block!!(0,"OK")
        hide()
    }
    
    /// Hide Alert Controller on background tap
    @objc func backgroundViewTapped(sender:AnyObject) {
        hide()
    }

    // MARK:- AJAlert Functions
    // MARK:-
    
    /// Display an Alert
    /// - Parameters:
    ///   - message: Message to display in Alert
    ///   - cancelButton: Cancel button title
    ///   - otherButton: Other button title
    ///   - completion: Completion block. Other Button Index - 1 and Cancel Button Index - 0
    public func showAlert( message:String, cancelButton:String?, otherButton:String?, completion : alertCompletionBlock) {
        configure( message: message, btnCancelTitle: cancelButton, btnOtherTitle: otherButton)
        show()
        block = completion
    }
    
    /// Display an Alert With "OK" Button
    /// - Parameters:
    ///   - aStrMessage: Message to display in Alert
    ///   - completion: Completion block. OK Button Index - 0
    public func showAlertWithOkButton( message:String, completion : alertCompletionBlock){
        configure(message: message, btnCancelTitle: nil, btnOtherTitle: nil)
        show()
        block = completion
    }
 }

