//
//  ViewController.swift
//  Passing Data
//
//  Created by Chris Kuang on 12/7/16.
//  Copyright © 2016 Chris Kuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // instantiate a text-field on the storyboard to collect user input
    @IBOutlet weak var myTextField: UITextField!
    
    // instantiate an action, triggered by a button press
    @IBAction func goToSecondVC(_ sender: Any) {
        
        // collect value of the user user input
        let userInput = myTextField.text
        
        // perform a segue to the second view controller, passing the entered data
        performSegue(withIdentifier: "goToSecondVC", sender: userInput)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // verify identifier of the segue
        if segue.identifier == "goToSecondVC" {
            
            // verify destination of the segue
            if let destination = segue.destination as? SecondVC {
                
                // set the variable in the destination view controller (SecondVC) with the user input
                destination.passedISBN = sender as? String
            }
        }
    }
}

