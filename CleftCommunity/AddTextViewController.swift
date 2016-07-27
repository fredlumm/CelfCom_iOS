//
//  AddTextViewController.swift
//  CleftCommunity
//  The view that let user to enter text of a new post.
//  Created by ShuaiFu on 15/11/26.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit
import Parse

class AddTextViewController: UIViewController, UITextViewDelegate {
    var newText: UITextView!
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize each component
        newText = UITextView(frame: CGRectMake(5, 70, self.view.frame.width - 10, 270))
        newText.delegate = self
        newText.layer.borderWidth = 0
        newText.editable = true
        newText.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        newText.becomeFirstResponder()
        self.view.addSubview(newText)
        self.automaticallyAdjustsScrollViewInsets = false
    }

    func textViewDidChange(textView: UITextView) {
        myPost.text = textView.text
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        newText.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
