//
//  ViewController.swift
//  HangmanGame
//
//  Created by Stefan Milenkovic on 3/15/19.
//  Copyright © 2019 Stefan Milenkovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var usedLetters = [String]()
    var pickedWord = [String]()
    var wrongAnswerCounter = 7 {
        didSet {
            title = "\(wrongAnswerCounter) attempts remaining"
        }
    }
    
    @IBOutlet weak var wordLabel: UILabel!
    
    
    var wordToFind: String = ""
    var word = "" {
        didSet {
            wordLabel.text = word
        }
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "\(wrongAnswerCounter) attempts remaining"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(enterChar))
        
        navigationItem.rightBarButtonItem = addButton
        
        let resetButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetGame))
        
        navigationItem.leftBarButtonItem = resetButton
        
        print("Hello game")
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
                //print(allWords.count)
            }else{
                allWords = ["silkworm"]
            }
        }
        
        startGame()
        
        
    }
    
    @objc func resetGame() {
        wrongAnswerCounter = 7
        usedLetters.removeAll()
        pickedWord.removeAll()
        word = ""
        startGame()
        
        
    }
    
    func pickChar(char: String) {
        
        word = ""
        
        if !usedLetters.contains(char){
            usedLetters.append(char)
            if !pickedWord.contains(char) {
                
                wrongAnswerCounter -= 1
                
                if wrongAnswerCounter == 0 {
                    title = "You lose"
                }
                
                
                
            }
        }else{
            
            print("already used letter")
        }
        
        for letter in wordToFind {
            if usedLetters.contains(String(letter)){
                word += String(letter) + " "
            }
            else{
                word += "_ "
                
            }
        }
        
        if !word.contains("_") {
            title = "YOU WIN THE GAME"
        }

    }
    
    @objc func enterChar() {
        
        let ac = UIAlertController(title: "Pick character", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?[0].keyboardType = .alphabet
        let pickAction = UIAlertAction(title: "Pick", style: .default) {
            [weak self] _ in
            guard let char = ac.textFields?[0].text?.first else {return}
            self?.pickChar(char: String(char))
            
            
        }
        
        ac.addAction(pickAction)
        present(ac, animated: true, completion: nil)
        
        
    }
    
    
    
    func startGame() {
        
        guard let picked = allWords.randomElement() else {
            return
            
        }
        wordToFind = picked
        
        for letter in wordToFind{
            pickedWord.append(String(letter))
            self.word += "_ "
            
        }
        
        print(wordToFind)
        
    }
    
    
}

