//
//  CashTxtFldDelegate.swift
//  DelegatesChallengeApp
//
//  Created by Mike Huffaker on 11/22/16.
//  Copyright © 2016 Mike Huffaker. All rights reserved.
//

import Foundation
import UIKit

class CashTxtFldDelegate: NSObject, UITextFieldDelegate
{
    //MHH - Validate Zip Code length
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        print( "CashTxtFldDelegate::shouldChangeCharactersIn()")
        let currentText = textField.text! as NSString
        let proposedText = string as NSString
        var backspace = false
        
        print( "existing text:", currentText )
        print( "user entered:", proposedText )
  
        //MHH - Backspace - bypass numeric check and set flag - do not return yet as the field still has to be re-formatted
        //      and the logic needs to remove the "leftmost" digit to mirror the editing style.
        if ( proposedText.length == 0 && range.length < currentText.length )
        {
            backspace = true
        }
        else
        {
            //MHH - next make sure the user didn't enter any non numeric data and reject edit if so
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
        }
        
        //MHH - remove formatting to build new value and rebuild as a float - may not be the best way to do 
        //      this in Swift, but I'm still learning the data types and available methods.
        var temp = ""
        if ( textField.text!.isEmpty )
        {
            temp = "0"
        }
        else
        {
            temp = textField.text!
            temp = temp.replacingOccurrences( of: "$", with: "" )
            temp = temp.replacingOccurrences( of: ".", with: "" )

            // MHH - if they hit backspace, remove the least significant digit from the string to "reverse"
            // the right to left way the text is entered.
            if backspace == true
            {
                let i = temp.index(before: temp.endIndex)
                temp.remove( at: i )
            }

        }
        temp.append(string)
        
        print( "CashTxtFldDelegate::unformatted new value will be:", temp )

        var finalValue = Double(temp)
        print( "CashTxtFldDelegate::finalvalue float is:", temp )
        finalValue? *= 0.01
        
        textField.text = String( format: "$%3.2f", finalValue! )
        print( "CashTxtFldDelegate::formatted new value will be:", textField.text )
        
        //MHH - return false because logic is adding what the user entered to the final formatted string value
        //      and will also handle backspace from left to right ( to mirror the right to left data entry )
        return false
    }
    
    //MHH - controls return key processing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        print( "CashTxtFldDelegate::textFieldShouldReturn()")
        textField.resignFirstResponder()
        
        return true;
    }
    
}
