//
//  MemoListTableViewController.swift
//  cloneMemoApp
//
//  Created by whyun on 2020/08/15.
//  Copyright © 2020 u2pia. All rights reserved.
//

import UIKit

class MemoListTableViewController: UITableViewController {
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()

    // 테이블이 화면에 다시 나타날때 호출되는 함수
    // 단, segue가 full screen일때에만 동작한다. modal에 same as destination 경우에는 동작안한다.
    // ios13부터는 full screen이 아닌 sheet 방식을 기본으로 한다.
    // 이걸 해결하려면 notification 방식을 적용해야 한다.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // ios13부터는 이 코드 필오없다.
        // 로그를 찍어준다. #function 하게 되면 함수이름을 찍어준다.
        print(#function)
    }
    
    var token: NSObjectProtocol?
    
    
    // 등록된 옵저버를 제거해 주어야 한다. 메모리 릭, 낭비 방지.
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
            print(#function)
            print("obeserver has bee removed")
        }
    }
    
    
    // segue의 source는 전 화면, destination은 연결된 다음 화면을 의미
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // as~~  는 type casting 문법
        // TO_KNOW: sender가 전 화면인지... 전 화면에서 특정 셀인지.... 좀 애매하다.
        //          --> sender와 segue source는 분리해서 봐야 한다.
        // TO_KNOW: tableView는 전역변수인가? 그냥 무작정 갖다 쓰네?
        
        
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            
            // segue.destination은 ViewController 타입이므로 우리가 원하는 클래스로 타입캐스팅 해 주어야 한다.
            if let vc = segue.destination as? DetailViewController {
                vc.memo = Memo.dummyMemoList[indexPath.row]
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 새로운 글이 달릴때 마다 리스트를 업데이트 하기 위한 observer를 등록하는 코드
        // 근데 마지막 줄은 의미를 모르겠다.
        
        // UI 업데이트는 메인 쓰레드에서 하는 것이 기본이라는 건 이해는 가는데..
        // 마지막 줄은 closure 함수라고 하는데... 뭐 저런 문법이 다 있노..
        token = NotificationCenter.default.addObserver(forName: MemoComposeViewController.newMemoDidInserted, object: nil, queue: OperationQueue.main, using:{ [weak self] (noti) in self?.tableView.reloadData() })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Memo.dummyMemoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let target = Memo.dummyMemoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(from: target.insertDate)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
