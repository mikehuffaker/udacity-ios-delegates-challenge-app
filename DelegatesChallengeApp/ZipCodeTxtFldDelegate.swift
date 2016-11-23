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
    //MHH - Validate Zip Code field length and contents
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        print( "ZipCodeTxtFldDelegate::shouldChangeCharactersIn()")
        let currentText = textField.text! as NSString
        let proposedText = string as NSString
        
        print( "existing text:", currentText )
        print( "user entered:", proposedText )
        
        //MHH - I couldn't find any other way to determine if backspace was pressed that didn't require code
        //      to try and compare hardcoded backspace value with CString value of the replacement String.
        //      Lots of different options on how this works and if it works or not for different versions of Swift.
        //      I couldn't get it to work consistantly and with Swift 3 changes.  So I found another way -
        //      if replacement string is null and the new range is less than the current text field size, 
        //      then the user hit backspace - I confirmed this is what happens using the debugger and with the
        //      numeric keypad this seems to be the only situation where range is set to less than current size.
        
        //MHH - Backspace - accept backspace edit.
        if ( proposedText.length == 0 && range.length < currentText.length )
        {
            return true
        }
        
        //MHH - first make sure the text isn't already 5 digits, if it is reject edit.
        if currentText.length > 4
        {
            return false
        }
        
        //MHH - next make sure the user didn't enter any non numeric data, if non numeric found, reject edit.
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
        // MHH - todo - actually catch "something" and log the error - still a bit fuzzy on how Swift handles exceptions, compared to Java/C++ 
        catch
        {
            print( "regular exception processing throws an error" )
        }
        
        //MHH - finally, check if user tried to paste something in that will make the zip code go beyond 5 digits
        //      If so, truncate the pasted date down so it will fit into whats left of the 5 digits, and 
        //      return false since the logic is adjusting the edit
        if ( proposedText.length + currentText.length > 5 )
        {
            textField.text?.append( proposedText.substring( to: ( 5 - currentText.length) ) )
            return false
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
