//
//  ViewController.swift
//  XMLParser
//
//  Created by Enxhi Buxheli on 12/7/16.
//  Copyright © 2016 Enxhi Buxheli. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Declare parser's variables
    var parser = XMLParser()
    var books = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var author1 = NSMutableString()
    
    // user ISBN is inputted
    var passedISBN: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parsingDataFromURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Parsing data from URL
    func parsingDataFromURL(){
        books = []
        
        // let isbnString = "http://isbndb.com/api/books.xml?access_key=1SMO7FG7&index1=isbn&value1=" + myLabel.text! as String!
        
        // readies the url for parsing (currently hardcoded)
        let isbnString = "http://isbndb.com/api/books.xml?access_key=1SMO7FG7&index1=isbn&value1=9780439577823"
        let isbnURL = URL(string: isbnString)
        
        parser = XMLParser(contentsOf: isbnURL!)!
        parser.delegate = self
        parser.parse()
        tableView.reloadData()
    }
    
    // XML item functions
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element = elementName as NSString
        
        if (elementName as NSString).isEqual(to: "BookData")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = " "
            author1 = NSMutableString()
            author1 = " "
        }
    }
    
    // adds relevant information into the array
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element .isEqual(to: "Title")
        {
            title1.append(string)
        }
        else if element.isEqual(to: "AuthorsText")
        {
            author1.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "BookData")
        {
            if !title1 .isEqual(nil)
            {
                elements.setObject(title1, forKey: "Title" as NSCopying)
            }
            
            if !author1 .isEqual(nil)
            {
                elements.setObject(author1, forKey: "AuthorsText" as NSCopying)
            }
            
            books.add(elements)
        }
    }
    
    // UITableView Data Source
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return books.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")! as UITableViewCell
        
        if (cell.isEqual(NSNull.self))
        {
            cell = Bundle.main.loadNibNamed("myCell", owner: self, options: nil)?[0] as! UITableViewCell
        }
        
        
        // Inputs parsed XML data into table
        cell.textLabel?.text = (books.object(at: indexPath.row) as AnyObject).value(forKey: "Title") as!
            NSString as String
        cell.detailTextLabel?.text = (books.object(at: indexPath.row) as AnyObject).value(forKey: "AuthorsText") as! NSString as String
        
        return cell
    }
}

