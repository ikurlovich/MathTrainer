//
//  ViewController.swift
//  MathTrainer
//
//  Created by Илья Курлович on 27.10.2023.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var ButtonCollection: [UIButton]!
    
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var subtractLabel: UILabel!
    @IBOutlet weak var multiplyLabel: UILabel!
    @IBOutlet weak var divideLabel: UILabel!
    
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    
    var countAdd = 0
    var countSubtract = 0
    var countMultiply = 0
    var countDivide = 0
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons()
        addCountLabels()
    }

    // MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        print("back")
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func configureButtons() {
        // Add shadow
        ButtonCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width:  0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
    
    private func addCountLabels() {
        addLabel.text = countAdd == 0 ? "-" : "\(countAdd)"
        subtractLabel.text = countSubtract == 0 ? "-" : "\(countSubtract)"
        multiplyLabel.text = countMultiply == 0 ? "-" : "\(countMultiply)"
        divideLabel.text = countDivide == 0 ? "-" : "\(countDivide)"
    }
}

