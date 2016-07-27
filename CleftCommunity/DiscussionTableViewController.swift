//
//  DiscussionTableViewController.swift
//  CleftCommunity
//  Table view that shows all the discussion threads.
//  Created by ShuaiFu on 15/11/1.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit
import Parse

var totalNum = 0
var postNum = 10

var loadMoreText = UILabel()
let tableFooterView = UIView()

class DiscussionTableViewController: UITableViewController {
    
    // MARK: - Upload new post
    @IBAction func unwindpost(segue: UIStoryboardSegue) {
        //add new post
        myPost.author = myInfo.nickname
        myPost.authorID = myInfo.ID
        let date = NSDate()
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-YY HH:mm"
        myPost.time = formatter.stringFromDate(date)
        
        let newPost = PFObject(className:"Post")
        newPost["title"] = myPost.title
        newPost["author"] = myPost.author
        newPost["authorID"] = myPost.authorID
        newPost["time"] = myPost.time
        newPost["text"] = myPost.text
        newPost["photo"] = PFFile(name:"image.jpg", data:myPost.pic)
        
        newPost["comNum"] = 0
        
        //get thread ID
        let query = PFQuery(className:"ThreadNum")
        query.whereKey("objectId", equalTo:"HTZ9XPAaMp")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for object in objects! {
                    var cnt = object["Num"] as! Int
                    cnt++
                    object["Num"] = cnt
                    newPost["tID"] = "\(cnt)"
                    myPost.tID = "\(cnt)"
                    newPost.saveInBackground()
                    object.saveInBackground()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        //only display once
        super.viewDidLoad()
        
        //pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string:"Refresh Data")
        self.refreshControl = refreshControl
        
        //pull to load more
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.createTableFooter()
        
        //load discussion
        loadDis()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false;
        //get info from parse
        if PFUser.currentUser() == nil {
            performSegueWithIdentifier("logInSignUp", sender: nil)
        }
        else{
            let id = PFUser.currentUser()?["ID"] as! String
            getmyinfo(id)
            getmyfriendsinfo(id)
        }
        
        //self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "logInSignUp"){
            let logInVC = segue.destinationViewController as! LoginParseViewController
            logInVC.hidesBottomBarWhenPushed = true
            logInVC.navigationItem.hidesBackButton = true
        }
        if(segue.identifier == "LogOut"){
            let logInVC = segue.destinationViewController as! logOutViewController
            logInVC.hidesBottomBarWhenPushed = true
        }
        if segue.identifier == "toNew" {
            let controller: AddImageViewController = segue.destinationViewController as! AddImageViewController
            controller.hidesBottomBarWhenPushed = true
        }
        if segue.identifier == "toDetail" {
            let controller: DisDetailViewController = segue.destinationViewController as! DisDetailViewController
            let cell: UITableViewCell = sender as!UITableViewCell
            let index: NSIndexPath = self.tableView.indexPathForCell(cell)!
            let img = cell.viewWithTag(1) as! UIImageView
            let lab = cell.viewWithTag(2) as! UILabel
            let lab2 = cell.viewWithTag(3) as! UILabel
            controller.hidesBottomBarWhenPushed = true
            controller.titlestring = lab.text
            controller.image = img.image
            controller.datestring = lab2.text
            controller.authorstring = threads[index.row].author + " (ID: " + threads[index.row].authorID + ")"
            controller.mainbodystring = threads[index.row].text
            controller.currentTID = threads[index.row].tID
            controller.navigationItem.title = "Detail"
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return threads.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscussionCell", forIndexPath: indexPath)
        
        // Configure the cell...
        // Design the sturcture of new cell
        if cell.viewWithTag(1) == nil {
            let iv = UIImageView()
            iv.tag = 1
            cell.contentView.addSubview(iv)
            let lab = UILabel()
            lab.tag = 2
            cell.contentView.addSubview(lab)
            let lab2 = UILabel()
            lab2.tag = 3
            cell.contentView.addSubview(lab2)
            let com = UIImageView()
            com.tag = 4
            cell.contentView.addSubview(com)
            let comNum = UILabel()
            comNum.tag = 5
            cell.contentView.addSubview(comNum)
            
            iv.frame = CGRectMake(10, 10, cell.contentView.frame.width*0.35, cell.contentView.frame.height - 20)
            iv.layer.cornerRadius = 5
            iv.layer.masksToBounds = true
            iv.layer.borderWidth = 0
            lab.frame = CGRectMake(20 + cell.contentView.frame.width*0.35, 0, cell.contentView.frame.width*0.65 - 30, cell.contentView.frame.height*0.6)
            lab.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            lab.numberOfLines = 2
            lab.textColor = UIColor.blackColor()
            lab2.frame = CGRectMake(20 + cell.contentView.frame.width*0.35, cell.contentView.frame.height*0.6 + 10, cell.contentView.frame.width*0.65 - 30, cell.contentView.frame.height*0.4 - 10)
            lab2.font = UIFont(name: "HelveticaNeue-Medium", size: 10)
            lab2.textAlignment = .Right
            lab2.textColor = UIColor.blackColor()
            com.frame = CGRectMake(20 + cell.contentView.frame.width*0.35, cell.contentView.frame.height*0.6 + 10, cell.contentView.frame.width*0.05, cell.contentView.frame.height*0.4 - 20)
            comNum.frame = CGRectMake(25 + cell.contentView.frame.width*0.4, cell.contentView.frame.height*0.6 + 10, cell.contentView.frame.width*0.1, cell.contentView.frame.height*0.4 - 20)
            comNum.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
            cell.selectionStyle = UITableViewCellSelectionStyle.Gray
            
        }
        // Assign value for each cell
        if threads.count >= self.tableView.numberOfRowsInSection(0) {
            let iv = cell.viewWithTag(1) as! UIImageView
            iv.image = UIImage(data: threads[indexPath.row].pic!)
            let lab = cell.viewWithTag(2) as! UILabel
            lab.text = threads[indexPath.row].title
            let lab2 = cell.viewWithTag(3) as! UILabel
            lab2.text = threads[indexPath.row].time
            let com = cell.viewWithTag(4) as! UIImageView
            com.image = UIImage(named: "Bubble2.png")
            let comNum = cell.viewWithTag(5) as! UILabel
            comNum.text = "\(threads[indexPath.row].commentNum)"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView.frame.width*0.3
    }
    
    func getmyinfo(id: String){
        let query = PFQuery(className:"UserInfo")
        query.whereKey("ID", equalTo:id)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                let objects = objects!
                for object in objects {
                    myInfo.nickname = object["nickname"] as! String
                    myInfo.ID = object["ID"] as! String
                    myInfo.email = object["email"] as! String
                    myInfo.gender = object["gender"] as! String
                    myInfo.age = object["age"] as! String
                    myInfo.motto = object["motto"] as! String
                    myInfo.phone = object["phone"] as! String
                    myInfo.region = object["region"] as! String
                    likeComments = object["likeComments"] as! Array<String>
                    let userImageFile = object["photo"] as! PFFile
                    userImageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            myInfo.photo = imageData
                        }
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func getmyfriendsinfo(id: String){
        friends.removeAll()
        let query = PFQuery(className:"UserInfo")
        query.whereKey("ID", equalTo:id)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                for object in objects! {
                    var arr = object["friends"] as! Array<String>
                    for(var i=0; i<arr.count; i++){
                        let newquery = PFQuery(className:"UserInfo")
                        newquery.whereKey("ID", equalTo:arr[i])
                        newquery.findObjectsInBackgroundWithBlock {
                            (newobjects: [PFObject]?, error: NSError?) -> Void in
                            if error == nil {
                                // Do something with the found objects
                                for user in newobjects! {
                                    let temp = UserInfo()
                                    temp.nickname = user["nickname"] as! String
                                    temp.ID = user["ID"] as! String
                                    temp.email = user["email"] as! String
                                    temp.age = user["age"] as! String
                                    temp.gender = user["gender"] as! String
                                    temp.motto = user["motto"] as! String
                                    temp.phone = user["phone"] as! String
                                    temp.region = user["region"] as! String
                                    let userImageFile = user["photo"] as! PFFile
                                    userImageFile.getDataInBackgroundWithBlock {
                                        (imageData: NSData?, error: NSError?) -> Void in
                                        if error == nil {
                                            temp.photo = imageData
                                        }
                                    }
                                    friends.append(temp)
                                }
                            } else {
                                // Log details of the failure
                                print("Error: \(error!) \(error!.userInfo)")
                            }
                            
                        }
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    //pull to refresh refresh
    func refresh() {
        loadDis()
        refreshControl?.endRefreshing()
    }
    
    //pull to load more
    func createTableFooter(){
        //create tableview's footerView
        self.tableView.tableFooterView = nil
        tableFooterView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 20)
        loadMoreText.frame =  CGRectMake(0, 0, self.tableView.bounds.size.width, 15)
        loadMoreText.text = "pull up toload more"
        loadMoreText.font = UIFont(name:"HelveticaNeue-Light", size: 10.0)
        loadMoreText.textColor = UIColor.grayColor()
        loadMoreText.textAlignment = NSTextAlignment.Center
        tableFooterView.addSubview(loadMoreText)
        self.tableView.tableFooterView = tableFooterView
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView){
        //begin to show the text in specific position
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 30){
            loadMoreText.text = "pull up to load more"
        }
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool){
        loadMoreText.text = "pull up to load more"
        if scrollView.contentSize.height-scrollView.contentOffset.y < scrollView.frame.size.height - 150{
            threads.sortInPlace(sortthreads)
            let curPos = Int(threads[threads.count-1].tID)
            loadOld(curPos!-1)
        }
    }

    
    func loadDis(){
        let query = PFQuery(className:"ThreadNum")
        query.whereKey("objectId", equalTo:"HTZ9XPAaMp")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for object in objects! {
                    totalNum = object["Num"] as! Int
                    self.beginload()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func beginload(){
        threads.removeAll()
        let threshold = (totalNum >= postNum) ? totalNum-postNum : 0
        for(var i=totalNum; i>threshold; i--){
            //perform a query
            let query = PFQuery(className:"Post")
            query.whereKey("tID", equalTo:"\(i)")
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    // Do something with the found objects
                    let objects = objects!
                    for object in objects {
                        let temp = Thread()
                        temp.tID = object["tID"] as! String
                        temp.author = object["author"] as! String
                        temp.authorID = object["authorID"] as! String
                        temp.title = object["title"] as! String
                        temp.text = object["text"] as! String
                        temp.time = object["time"] as! String
                        let userImageFile = object["photo"] as! PFFile
                        temp.commentNum = object["comNum"] as! Int
                        userImageFile.getDataInBackgroundWithBlock {
                            (imageData: NSData?, error: NSError?) -> Void in
                            if error == nil {
                                temp.pic = imageData
                            }
                        }
                        threads.append(temp)
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        threads.sortInPlace(self.sortthreads)
                        self.tableView.reloadData()
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
    }
    
    func sortthreads(x: Thread, y: Thread) -> Bool{
        return Int(x.tID) > Int(y.tID)
    }
    
    func loadOld(pos: Int){
        let threshold = (pos >= postNum) ? pos-postNum : 0
        for(var i=pos; i>threshold; i--){
            //perform a query
            let query = PFQuery(className:"Post")
            query.whereKey("tID", equalTo:"\(i)")
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    // Do something with the found objects
                    let objects = objects!
                    for object in objects{
                        let temp = Thread()
                        temp.tID = object["tID"] as! String
                        temp.author = object["author"] as! String
                        temp.authorID = object["authorID"] as! String
                        temp.title = object["title"] as! String
                        temp.text = object["text"] as! String
                        temp.time = object["time"] as! String
                        let userImageFile = object["photo"] as! PFFile
                        userImageFile.getDataInBackgroundWithBlock {
                            (imageData: NSData?, error: NSError?) -> Void in
                            if error == nil {
                                temp.pic = imageData
                            }
                        }
                        threads.append(temp)
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        threads.sortInPlace(self.sortthreads)
                        self.tableView.reloadData()
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
