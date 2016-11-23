//
//  ViewController.swift
//  DelegatesChallengeApp
//
//  Created by Mike Huffaker on 11/15/16.
//  Copyright © 2016 Mike Huffaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var txtCash: UITextField!
    @IBOutlet weak var txtLockable: UITextField!
    @IBOutlet weak var swtchLockable: UISwitch!
    
    let zipCodeDelegate = ZipCodeTxtFldDelegate()
    let cashDelegate = CashTxtFldDelegate()

    override func viewDidLoad()
    {
        print( "ViewController::viewDidLoad()" )
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.txtZipCode.delegate = zipCodeDelegate
        self.txtCash.delegate = cashDelegate
        self.txtLockable.delegate = self
    }

    @IBAction func swtchLockableChange(_ sender: AnyObject)
    {
        print( "ViewController::swtchLockableChange()" )
        if !(sender as! UISwitch).isOn
        {
            self.txtLockable.resignFirstResponder()
        }
    }
    
    //MHH - For the 3rd txtLockable field, the ViewController is also the Text Field
    //      Delegate since there isn't much to do except for turning the editing on/off
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        print( "ViewController::textFieldShouldBeginEditing()" )
        return swtchLockable.isOn
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        print( "ViewController::textFieldShouldReturn()" )
        textField.resignFirstResponder()
        return true;
    }
}

