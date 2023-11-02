//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Илья Курлович on 28.10.2023.
//

import UIKit

final class TrainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    
    private var count: Int = 0 {
        didSet {
            print("Count: \(count)")
            scoreLabel.text = "Score: \(count)"
        }
    }

    var type: MathTypes = .add {
        didSet {
            print(type)
            
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureQuestion()
        configureButtonsTrain()
    }
    // MARK: - IBActions
    
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    
    // MARK: - Methods
    private func configureButtonsTrain() {
        let buttonsArray = [rightButton, leftButton]
        
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemYellow
            
        }
        // Add shadow
        buttonsArray.forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width:  0, height: 2)
            button?.layer.shadowOpacity = 0.4
            button?.layer.shadowRadius = 3
        }
        
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        leftButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        rightButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
    }
    
    private func configureQuestion() {
        switch sign {
        case "/":
            firstNumber = Int.random(in: 2...99)
            secondNumber = Int.random(in: 1..<firstNumber)

            while firstNumber % secondNumber != 0 {
                firstNumber = Int.random(in: 2...99)
                secondNumber = Int.random(in: 1..<firstNumber)
            }
        case "*":
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...10)
        default:
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...99)
        }
        
        let question = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }

    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .systemGreen : .systemRed
        
        if isRightAnswer {
            let isSecondAttempt = rightButton.backgroundColor == .systemRed || leftButton.backgroundColor == .systemRed
            count += isSecondAttempt ? 0 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtonsTrain()
            }
        }
    }
}
