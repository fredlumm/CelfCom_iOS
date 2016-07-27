//
//  DisDetailViewController.swift
//  CleftCommunity
//  The view that shows detail information of each discussion thread.
//  Created by ShuaiFu on 15/11/21.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit

class DisDetailViewController: UIViewController {
    
    var titlestring: String!
    var datestring: String!
    var authorstring: String! = ""
    var mainbodystring: String! = ""
    var mytitle: UILabel!
    var author: UILabel!
    var date: UILabel!
    var mainbody: UITextView!
    var imageView: UIImageView!
    var image: UIImage!
    var currentTID:String!
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize each component
        mytitle = UILabel(frame: CGRectMake(10, 70, self.view.frame.width - 20, 60))
        mytitle.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        mytitle.numberOfLines = 2
        mytitle.text = titlestring
        self.view.addSubview(mytitle)
        author = UILabel(frame: CGRectMake(10, 130, self.view.frame.width*0.60, 30))
        author.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        author.adjustsFontSizeToFitWidth = true
        author.minimumScaleFactor = 0.5
        author.text = "Author: " + authorstring
        self.view.addSubview(author)
        date = UILabel(frame: CGRectMake(self.view.frame.width*0.60 + 10, 130, self.view.frame.width*0.40 - 20, 30))
        date.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        date.text = datestring
        date.textAlignment = .Right
        self.view.addSubview(date)
        mainbody = UITextView(frame: CGRectMake(10, 360, self.view.frame.width - 20, self.view.frame.height - 360))
        mainbody.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        mainbody.text = mainbodystring
        mainbody.backgroundColor = UIColor.clearColor()
        mainbody.editable = false
        self.view.addSubview(mainbody)
        imageView = UIImageView(frame: CGRectMake((self.view.frame.width - 240)/2, 170, 240, 180))
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        imageView.image = image
        self.view.addSubview(imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showComments"){
            // add comments to the detail thread
            let CommentVC = segue.destinationViewController as! CommentsTableViewController
            CommentVC.currentTID = self.currentTID
            
        }
    }
}
