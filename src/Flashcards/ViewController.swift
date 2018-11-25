//
//  ViewController.swift
//  Flashcards
//
//  Created by Cora Xing on 10/26/18.
//  Copyright © 2018 Cora Yichen Xing. All rights reserved.
//


import UIKit

// Flashcard struct that stores question and answer
struct Flashcard {
    var question: String
    var answer: String
    var extraAnswer1: String
    var extraAnswer2: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    // Current flashcards index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Adding initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What's the average runtime of quicksort?", answer: "O(n^2)", extraAnswer1: "O(nlogn)", extraAnswer2: "O(logn)", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
        // Change appearance of labels
        frontLabel.layer.cornerRadius = 30.0 // create rounded card
        frontLabel.clipsToBounds = true // clip front label inside
        backLabel.layer.cornerRadius = 30.0 // create rounded card
        backLabel.clipsToBounds = true // clip front label inside
        
        // Change appearance of cards
        card.layer.cornerRadius = 30.0 // create rounded card
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        // Change appearance of buttons
        
        // Button 1
        btnOptionOne.layer.cornerRadius = 15.0
        btnOptionOne.layer.borderWidth = 3
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.2790087163, green: 0.09912771732, blue: 0.324397862, alpha: 1)
        
        // Button 2
        btnOptionTwo.layer.cornerRadius = 15.0
        btnOptionTwo.layer.borderWidth = 3
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.2790087163, green: 0.09912771732, blue: 0.324397862, alpha: 1)
        
        // Button 3
        btnOptionThree.layer.cornerRadius = 15.0
        btnOptionThree.layer.borderWidth = 3
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.2790087163, green: 0.09912771732, blue: 0.324397862, alpha: 1)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
        print("test")
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        print("Tapped on next button")
        // Increase current index
        currentIndex = currentIndex + 1
        
        print("New currentIndex is \(currentIndex)")
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        print("Tapped on delete")
        
        // Show confirmation
        let alert = UIAlertController(title:"Delete Flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        present(alert, animated: true)
        
        // Add delete action
        let deleteAction = UIAlertAction(title:"Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        
        alert.addAction(deleteAction)
        
        // Add cancel action
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
    }
    
    func deleteCurrentFlashcard() {
        // Delete current
        
        flashcards.remove(at: currentIndex)
        
        // Special case: check if last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        // Update buttons and labels and save to disk
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
        
        // TODO: figure out how to address currentIndex == -1 crashing
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        print("Tapped on previous button")
        // Increase current index
        currentIndex = currentIndex - 1
        
        print("New currentIndex is \(currentIndex)")
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOutside(_ sender: Any) {
        // Resets flashcard settings
        resetLabelColors()
        
    }
    
    func updateLabels() {
        // Get current flashcard
        print("Updating labels ... ")
        print("Current index is \(currentIndex)")
        
        let currentFlashcard = flashcards[currentIndex]
        
        // update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        btnOptionOne.setTitle(currentFlashcard.extraAnswer1, for: .normal)
        btnOptionTwo.setTitle(currentFlashcard.answer, for: .normal)
        btnOptionThree.setTitle(currentFlashcard.extraAnswer2, for: .normal)
        
        resetLabelColors()
    }
    
    func resetLabelColors() {
        frontLabel.isHidden = false
        btnOptionOne.isHidden = false
        btnOptionTwo.isHidden = false
        btnOptionThree.isHidden = false
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswer1: String, extraAnswer2: String, isExisting: Bool) {
        
         let flashcard = Flashcard(question: question, answer: answer, extraAnswer1: extraAnswer1, extraAnswer2: extraAnswer2)
        
        if(isExisting) {
            // Replace existing flashcard
            flashcards[currentIndex] = flashcard
            
        } else {
            // Adding flashcard into flashcards array
            flashcards.append(flashcard)
            
            // Logging to console
            print("Added new flashcard")
            print("We now have \(flashcards.count) flashcards")
            
            // Update current index
            currentIndex = flashcards.count - 1
            print("Our current index is \(currentIndex)")
            
            // Update buttons
            updateNextPrevButtons()
            
            // Update labels
            updateLabels()
            
            // Save all flashcards to disk
            saveAllFlashcardsToDisk()
        }
    }
    
    func updateNextPrevButtons() {
        print("Updating next and previous buttons ... ")
        print("Current index = \(currentIndex)")
        // Disable nextButton if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        // Disable prev button if at beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func readSavedFlashcards() {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            
            // In here we know for sure that we have a dictionary array
            let savedCards = dictionaryArray.map {  dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswer1: dictionary["extraAnswer1"]!, extraAnswer2: dictionary["extraAnswer2"]!)
            }
            
            // Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func saveAllFlashcardsToDisk() {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer": card.answer, "extraAnswer1": card.extraAnswer1, "extraAnswer2": card.extraAnswer2]
        }
        
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults!")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We know the destination of the segue is in the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // We set the flashcardsController property to self
        creationController.flashcardsController = self
        
        // Set initial values if and only if segue's identifier is EditSegue
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            creationController.initialExtraAnswer1 = btnOptionOne.currentTitle
            creationController.initialExtraAnswer2 = btnOptionThree.currentTitle
        }
        
        
    }
}

