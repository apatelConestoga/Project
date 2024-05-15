//
//  ViewController.swift
//  Calculator
//
//  Created by Adeesh on 2024-05-14.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outklets
    
    @IBOutlet weak var textFieldFirst: UITextField!
    @IBOutlet weak var textFieldSecond: UITextField!
    @IBOutlet weak var textFieldResult: UITextField!
    @IBOutlet weak var buttonZero: UIButton!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var buttonNine: UIButton!
    @IBOutlet weak var buttonEqual: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonMultipe: UIButton!
    @IBOutlet weak var buttonDivide: UIButton!
    @IBOutlet weak var buttonSquareRoot: UIButton!
    @IBOutlet weak var buttonPlusORMinus: UIButton!
    @IBOutlet weak var buttonResett: UIButton!
    @IBOutlet weak var buttonDot: UIButton!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureOutlets()
    }
}

//MARK: -  Private Function
extension ViewController {
    private func configureOutlets() {
        buttonZero.layer.cornerRadius = 30
        buttonOne.layer.cornerRadius = self.buttonOne.frame.width / 2
        buttonTwo.layer.cornerRadius = self.buttonTwo.frame.width / 2
        buttonThree.layer.cornerRadius = self.buttonThree.frame.width / 2
        buttonFour.layer.cornerRadius = self.buttonFour.frame.width / 2
        buttonFive.layer.cornerRadius = self.buttonFive.frame.width / 2
        buttonSix.layer.cornerRadius = self.buttonSix.frame.width / 2
        buttonSeven.layer.cornerRadius = self.buttonSeven.frame.width / 2
        buttonEight.layer.cornerRadius = self.buttonEight.frame.width / 2
        buttonNine.layer.cornerRadius = self.buttonNine.frame.width / 2
        buttonEqual.layer.cornerRadius = self.buttonEqual.frame.width / 2
        buttonPlus.layer.cornerRadius = self.buttonPlus.frame.width / 2
        buttonMinus.layer.cornerRadius = self.buttonMinus.frame.width / 2
        buttonMultipe.layer.cornerRadius = self.buttonMultipe.frame.width / 2
        buttonDivide.layer.cornerRadius = self.buttonDivide.frame.width / 2
        buttonSquareRoot.layer.cornerRadius = self.buttonSquareRoot.frame.width / 2
        buttonPlusORMinus.layer.cornerRadius = self.buttonPlusORMinus.frame.width / 2
        buttonResett.layer.cornerRadius = self.buttonResett.frame.width / 2
        buttonDot.layer.cornerRadius = self.buttonDot.frame.width / 2
    }
}

//MARK: -  Button Actions
extension ViewController {
    @IBAction func ButtonNumericClick(_ sender: UIButton) {
        print(sender.tag)
    }
    
    @IBAction func ButtonOthValueClick(_ sender: UIButton) {
        print(sender.tag)
            
    }
}

