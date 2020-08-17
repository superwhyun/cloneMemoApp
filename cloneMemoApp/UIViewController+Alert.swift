//
//  UIViewController+Alert.swift
//  cloneMemoApp
//
//  Created by whyun on 2020/08/16.
//  Copyright © 2020 u2pia. All rights reserved.
//


// Foundation으로 되어 있는 것을 UIKit으로 바꿔준다.
import UIKit


// 다른데에서도 불러쓸 수 있도록 extension으로 선언한다.
// 기존 UIViewController에 새로운 기능을 추가하는 것으로 보인다.
extension UIViewController {
    func alert(title: String = "알려유", message: String) {
        
        //Alert Style은 Alert View, Alert Sheet 두 종류가 있다.
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인" ,  style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
}
