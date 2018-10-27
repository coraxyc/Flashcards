//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Cora Xing on 10/27/18.
//  Copyright © 2018 Cora Yichen Xing. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerTextField1: UITextField!
    @IBOutlet weak var extraAnswerTextField2: UITextField!
    
    
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnDone(_ sender: Any) {
        // Get text in question text field
        let questionText = questionTextField.text
        
        // Get the text in the answer field
        let answerText = answerTextField.text
        let extraAnswerText1 = extraAnswerTextField1.text
        let extraAnswerText2 = extraAnswerTextField2.text
        
        // Call the function to update the flashcard
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswer1: extraAnswerText1!, extraAnswer2: extraAnswerText2!)
        
        dismiss(animated: true)
    }
    
    
    
    // Call the function to update the flashcard
    
    
    
}
