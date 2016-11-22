//
//  ZipCodeTxtFldDelegate.swift
//  DelegatesChallengeApp
//
//  Created by Mike Huffaker on 11/18/16.
//  Copyright © 2016 Mike Huffaker. All rights reserved.
//

import Foundation
import UIKit

class ZipCodeTxtFldDelegate: NSObject, UITextFieldDelegate
{
    //MHH - Validate Zip Code length
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        print( "ZipCodeTxtFldDelegate::shouldChangeCharactersIn()")
        let currentText = textField.text! as NSString
        let proposedText = string as NSString
        
        print( "existing text:", currentText )
        print( "user entered:", proposedText )
        
        //MHH - I couldn't find any other way to determine this that didn't require additional code to try
        //      and harcode the backspace value into a C String and compare it - lots of different options on
        //      if this works or not on StackExchange.
        //      So I found another way -
        //      if replacement string is null and the new range is less than the current text field size, 
        //      the user hit backspace - I confirmed this is what happens using the debugger.
        
        //MHH - Backspace - accept edit and exit out.
        if ( proposedText.length == 0 && range.length < currentText.length )
        {
            return true
        }
        
        //MHH - first make sure the text isn't already 5 digits
        if currentText.length > 4
        {
            return false
        }
        
        //MHH - next make sure the user didn't enter any non numeric data
        let pattern = "\\D"
        
        do
        {
            let regExpression = try NSRegularExpression( pattern: pattern, options:NSRegularExpression.Options.caseInsensitive )
            let matches = regExpression.numberOfMatches( in: proposedText as String, options: [], range: NSMakeRange(0, proposedText.length) )
            print( "non-digits found:", matches )
            if matches > 0
            {
                return false
            }
        }
        catch
        {
            print( "regular exception processing throws an error" )
        }
        
        return true
    }

    //MHH - controls return key processing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        print( "ZipCodeTxtFldDelegate::textFieldShouldReturn()")
        textField.resignFirstResponder()
    
        return true;
    }

}
