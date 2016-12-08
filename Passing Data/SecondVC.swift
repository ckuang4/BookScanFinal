//
//  SecondVC.swift
//  Passing Data
//
//  Created by Chris Kuang on 12/7/16.
//  Copyright © 2016 Chris Kuang. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    
    // instantiates two storyboard elements -- a text label and a UIWebView to display websites
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var isbnView: UIWebView!
    
    // declare passedISBN as a variable to prepare to "receive" data from the first VC.
    var passedISBN: String!
    
    override func viewDidLoad() {
        
        // set the text of the UILabel to be the user input received
        myLabel.text = passedISBN
        
        // declare a variable in preparation for creating an API request
        var isbnString: String!
        
        // access ISBNdb API, passing in the unique ISBN from the user input
        isbnString = "http://isbndb.com/api/books.xml?access_key=1SMO7FG7&index1=isbn&value1=" + myLabel.text! as String!
        
        // verify whether the URL is valid
        guard let myURL = URL(string: isbnString) else {
            print("Error: \(isbnString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let isbnString = try String(contentsOf: myURL, encoding: .ascii)
            
            // display the marked-up HTML version of what is returned from the API
            myLabel.text = "HTML : \(isbnString)"
        }
            
        // check for errors
        catch let error {
            print("Error: \(error)")
        }
        
        // initiate the UIWebView with the URL used to create the API request to ISBNdb
        let isbnURL = URL(string: isbnString)
        let isbnURLRequest = URLRequest(url: isbnURL!)
        isbnView.loadRequest(isbnURLRequest)
        
        super.viewDidLoad()
        
    }
}
