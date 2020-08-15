//
//  Model.swift
//  cloneMemoApp
//
//  Created by whyun on 2020/08/15.
//  Copyright © 2020 u2pia. All rights reserved.
//

import Foundation

class Memo {
    var content: String
    var insertDate: Date
    
    init(content: String) {
        self.content = content
        insertDate = Date()
    }
    static var dummyMemoList = [
        Memo(content: "Shitman"),
        Memo(content: "fucking")
    ]
    
}

