//
//  LiveTableViewController.swift
//  YKLiveStream
//
//  Created by 裴塔塔 on 5/29/16.
//  Copyright © 2017 peitata. All rights reserved.
//  主播列表

import UIKit
import Just//请求
import Kingfisher//设置图片的

class LiveTableViewController: UITableViewController {

//    链接
    let livelisturl = "http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"
//    列表数组
    var list : [YKCell] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadList()
        
//        控制器自带的下拉刷新
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadList), for: .valueChanged)
    }

    func loadList() {
//        r是结果
        Just.post(livelisturl) { (r) in
//            保证返回的结果是json
            guard let json = r.json as? NSDictionary else{
                return
            }
//            取出yklive数据
            let lives = YKLiveStream(fromDictionary: json).lives!
            
//            把数据转换为列表数组
            self.list = lives.map({ (live) -> YKCell in
                return YKCell(portrait: live.creator.portrait, nick: live.creator.nick, city: live.city, viewers: live.onlineUsers, url: live.streamAddr)
            })
            
//            打印
//            dump(self.list)
//            主线程更新界面
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                
//            下拉刷新停止
            self.refreshControl?.endRefreshing()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LiveTableViewCell

//        as! LiveTableViewCell  cell强制转换
        
        let live = list[indexPath.row]
        
        cell.city.text = live.city
        cell.labelnick.text = live.nick
        cell.numbers.text = "\(live.viewers)"
        
//        小头像
        let imgurl = URL(string: live.portrait)
        
        cell.imgpor.kf.setImage(with: imgurl)
        
//        大图
        cell.bigimg.kf.setImage(with: imgurl)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
   
    navigationController?.setNavigationBarHidden(true, animated: true)
        
//        取出下个页面的控制器
        let dest = segue.destination as! ViewController
        dest.live = list[(tableView.indexPathForSelectedRow?.row)!]
    
    }
 

}
