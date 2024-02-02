//
//  ViewController.swift
//  BMIapp
//
//  Created by Dumindu Harshana on 2024-02-01.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var infotext: UILabel!
    @IBOutlet weak var mesurementSegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func calculateBMI(_ sender: Any) {
        // Check if height and weight are valid numbers
        guard let height = Double(heightTextField.text ?? ""),
              let weight = Double(weightTextField.text ?? "") else {
            resultLabel.text = "Please enter valid height and weight."
            return
        }
        let selectedSegmentIndex = mesurementSegmentedControl.selectedSegmentIndex
        let isImperial = selectedSegmentIndex == 1
        
        // Convert height and weight based on the selected measurement system
        let convertedHeight = convertHeight(height, isImperial: isImperial)
        let convertedWeight = convertWeight(weight, isImperial: isImperial)
        
        // Calculate BMI
        let bmi = convertedWeight / (convertedHeight * convertedHeight)
        
        // Display the result and BMI category
        displayResult(bmi)
    }
    
    func convertHeight(_ height: Double, isImperial: Bool) -> Double {
        switch isImperial {
        case true:
            // Convert height from inches to meters
            return height * 0.0254
        case false:
            // Height is already in centimeters (SI)
            return height / 100
        }
    }
    
    func convertWeight(_ weight: Double, isImperial: Bool) -> Double {
        switch isImperial {
        case true:
            // Convert weight from pounds to kilograms
            return weight * 0.453592
        case false:
            // Weight is already in kilograms (SI)
            return weight
        }
    }
    
    func displayResult(_ bmi: Double) {
        var resultText = "BMI: \(String(format: "%.2f", bmi))\nCategory: "
        var resultinfo="";
        // Determine the BMI category
        if bmi < 18.5 {
            resultinfo += "Underweight"
        } else if bmi < 24.9 {
            resultinfo += "Normal Weight"
        } else if bmi < 29.9 {
            resultinfo += "Overweight"
        } else {
            resultinfo += "Obese"
        }
        resultLabel.text=resultText
        infotext.text = resultinfo
    }
}
