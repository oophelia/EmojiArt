//
//  TextFieldCollectionViewCell.swift
//  EmojiArt
//
//  Created by Echo Wang on 8/30/19.
//  Copyright © 2019 Echo Wang Studio. All rights reserved.
//

import UIKit

class TextFieldCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
 
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    // use closures to communicate with collection view 
    var resignationHandler: (() -> Void)?
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignationHandler?()
    }
    
    // when press return on the keyboard, keyboard will go away
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
