//
//  MoveScrollViewEithKeyboard.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 27.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addObserversForKeyboardAppearanceToMoveScrollView (vc: UIViewController, scrollView: UIScrollView) {
        NotificationCenter.default.addObserver(self, selector: #selector(vc.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(vc.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification, scrollView: UIScrollView) {
        //let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        //let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        //let keyboardSize = keyboardInfo.cgRectValue.size
        scrollView.contentOffset = CGPoint(x:0, y:80)
    }
    
    @objc func keyboardWillHide(notification: NSNotification, scrollView: UIScrollView) {
        scrollView.contentOffset = .zero
    }
    
}
