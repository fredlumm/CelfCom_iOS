//
//  FriendsTableViewController.swift
//  CleftCommunity
//  Table view that show all user's friends.
//  Created by ShuaiFu on 15/11/1.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit
import Parse

class FriendsTableViewController: UITableViewController {
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        friends.sortInPlace(sortfriends)
        self.tableView.reloadData()
    }
    
    func sortfriends(x: UserInfo, y: UserInfo) -> Bool{
        return x.nickname < y.nickname
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendsCell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Medium", size: 14.0)
        cell.textLabel?.text = friends[indexPath.row].nickname
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //update friends list
        let removeID = friends[indexPath.row].ID
        friends.removeAtIndex(indexPath.row)
        pushtoparse(removeID)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Unfollow"
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showprofile"{
            if let destination = segue.destinationViewController as? ShowFriendInfoTableViewController {
                if let proIndex = tableView.indexPathForSelectedRow?.row {
                    destination.userInfo = friends[proIndex]
                }
                destination.hidesBottomBarWhenPushed = true
            }
        }
        else{
            let destination = segue.destinationViewController as? AddFriendViewController
            destination?.hidesBottomBarWhenPushed = true
        }
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        self.tableView.reloadData()
    }
    
    //Upload that a friend has been unfollowed
    func pushtoparse(index: String){
        let query = PFQuery(className:"UserInfo")
        query.whereKey("ID", equalTo:myInfo.ID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                for object in objects! {
                    var arr = object["friends"] as! Array<String>
                    for(var i=0; i<arr.count; i++){
                        if(arr[i] == index){
                            arr.removeAtIndex(i)
                            break
                        }
                    }
                    object["friends"] = arr
                    object.saveInBackground()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
    }
}

