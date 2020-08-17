//
//  MemoComposeViewController.swift
//  cloneMemoApp
//
//  Created by whyun on 2020/08/16.
//  Copyright © 2020 u2pia. All rights reserved.
//

import UIKit

class MemoComposeViewController: UIViewController {

    
    @IBAction func close(_ sender: Any) {
        
//        Modal로 생성된 화면을 없앨때는 dismiss를 이용함
//        dismiss(animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//        animated는 true로 하고, completion은 종료된 이후 실행되는 코드를 의미함
//        종료후 실행될 코드가 없으므로 nil을 전달함.
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    
    
    @IBAction func save(_ sender: Any) {
        guard let memo = memoTextView.text, memo.count > 0 else {
            alert(message: "메모가 비었슈. 니 대구빡마냥")
            return
            
        }
        
        let newMemo = Memo(content: memo)
        Memo.dummyMemoList.append(newMemo)
        
        NotificationCenter.default.post(name: MemoComposeViewController.newMemoDidInserted, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MemoComposeViewController {
    static let newMemoDidInserted = Notification.Name(rawValue: "newMemoDidInserted")
}
