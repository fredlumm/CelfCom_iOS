//
//  AddCommentsViewController.swift
//  CleftCommunity
//  The view that let user to enter a comment.
//  Created by ShuaiFu on 15/11/28.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit
import Parse

class AddCommentsViewController: UIViewController, UITextViewDelegate {
    
    var newComment: UITextView!
    var currentTID:String!
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize each component.
        newComment = UITextView(frame: CGRectMake(5, 70, self.view.frame.width - 10, 270))
        newComment.delegate = self
        newComment.layer.borderWidth = 0
        newComment.editable = true
        newComment.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        newComment.becomeFirstResponder()
        self.view.addSubview(newComment)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        newComment.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
