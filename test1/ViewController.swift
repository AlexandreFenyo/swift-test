//
//  ViewController.swift
//  test1
//
//  Created by Alexandre Fenyo on 23/03/2018.
//  Copyright © 2018 Alexandre Fenyo. All rights reserved.
//

import UIKit
import CoreFoundation

class ViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var console: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    
    @IBAction func bouton(_ sender: UIButton) {
        // nameTextField.text = "salut";
        console.text = console.text + "bouton(_:) called\n";
    }
    
    @IBAction func action1(_ sender: UIButton) {
        print("action1")
    }
    
    @IBAction func action2(_ sender: UIButton) {
        func cb(_ s : CFSocket?, _ type : CFSocketCallBackType, _data : CFData?, _p1 : UnsafeRawPointer?, _p2 : UnsafeMutableRawPointer?) {
            print("Socket callback called")
        }
        
        let s : CFSocket! = CFSocketCreate(nil, PF_INET, SOCK_STREAM, IPPROTO_TCP, CFSocketCallBackType.acceptCallBack.rawValue, cb, nil)
        if (s == nil) {
            print("CFSocketCreate returned nil")
            return
        }

        var sin = sockaddr_in(
            sin_len: UInt8(MemoryLayout<sockaddr_in>.size),
            sin_family: sa_family_t(AF_INET),
            sin_port: in_port_t(myC_htons(8888)),
            sin_addr: in_addr(s_addr: INADDR_ANY),
            sin_zero: (0,0,0,0,0,0,0,0)
        )
        
// https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/WorkingWithCocoaDataTypes.html#//apple_ref/doc/uid/TP40014216-CH6
        
        let data = NSData(bytes: &sin, length: MemoryLayout<sockaddr_in>.size) // as CFData
        let cfSocketError : CFSocketError = CFSocketSetAddress(s, data)
        if (cfSocketError != CFSocketError.success) {
            print("cfSocketError:", cfSocketError.rawValue)
        } else {
            print("socket bound")
        }
    }
    
    @IBAction func action3(_ sender: UIButton) {
    }
}

