//
//  ViewController.swift
//  Swiftbook_2
//
//  Created by Andrey Borovilov on 11/02/2020.
//  Copyright © 2020 Andrey Borovilov. All rights reserved.
//

import UIKit

protocol ChangeColorDelegate {
    var colorValue: UIColor { get }
    func changeColor(color: UIColor)
}

class ViewController: UIViewController {

    @IBOutlet var currentView: UIView!
    @IBOutlet var sliderRed: UISlider!
    @IBOutlet var sliderGreen: UISlider!
    @IBOutlet var sliderBlue: UISlider!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var redValueTextField: UITextField!
    
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var greenValueTextField: UITextField!
    
    @IBOutlet var blueValueLabel: UILabel!
    @IBOutlet var blueValueTextField: UITextField!
    
    @IBOutlet var colorPalette: UIView!
    
    @IBOutlet var doneButtone: UIButton!
    
    private var redValue: CGFloat!
    private var greenValue: CGFloat!
    private var blueValue: CGFloat!
    private var alphaValue: CGFloat!
    
    var delegate: ChangeColorDelegate!
    //var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for textField in [redValueTextField,greenValueTextField, blueValueTextField] {
            textField?.delegate = self
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        colorPalette.backgroundColor = delegate.colorValue
        customizeSubViews()
    }
    
    private func customizeSubViews() {
        let currentColorPalette = colorPalette.backgroundColor
        
        redValue = currentColorPalette!.redValue
        greenValue = currentColorPalette!.greenValue
        blueValue = currentColorPalette!.blueValue
        alphaValue = currentColorPalette!.alphaValue
        
        sliderRed.minimumValue = 0
        sliderRed.maximumValue = 255
        sliderRed.value = Float(redValue*255)
        redValueLabel.text = String(format: "%.2f", sliderRed.value)
        redValueTextField.text = String(format: "%.2f", sliderRed.value)
        
        sliderGreen.minimumValue = 0
        sliderGreen.maximumValue = 255
        sliderGreen.value = Float(greenValue*255)
        greenValueLabel.text = String(format: "%.2f", sliderGreen.value)
        greenValueTextField.text = String(format: "%.2f", sliderGreen.value)
        
        sliderBlue.minimumValue = 0
        sliderBlue.maximumValue = 255
        sliderBlue.value = Float(blueValue*255)
        blueValueLabel.text = String(format: "%.2f", sliderBlue.value)
        blueValueTextField.text = String(format: "%.2f", sliderBlue.value)
    }

    @IBAction func changeChannels(_ sender: UISlider) {
        switch sender.accessibilityIdentifier! {
            case "red":
                redValueLabel.text = String(format: "%.2f", sliderRed.value)
                redValueTextField.text = String(format: "%.2f", sliderRed.value)
                
                redValue = CGFloat(sliderRed.value)/255
                
            case "green":
                greenValueLabel.text = String(format: "%.2f", sliderGreen.value)
                greenValueTextField.text = String(format: "%.2f", sliderGreen.value)
                
                greenValue = CGFloat(sliderGreen.value)/255

            case "blue":
                blueValueLabel.text = String(format: "%.2f", sliderBlue.value)
                blueValueTextField.text = String(format: "%.2f", sliderBlue.value)
                
                blueValue = CGFloat(sliderBlue.value)/255
            default:
                print("changing")
        }
        colorPalette.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
    }
    
    @IBAction func donePressed() {
        delegate.changeColor(color: UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue))
        dismiss(animated: true, completion: nil)
    }
}

extension UIColor {

    var redValue: CGFloat{
        return cgColor.components! [0]
    }
    var greenValue: CGFloat{
        return cgColor.components! [1]
    }
    var blueValue: CGFloat{
        return cgColor.components! [2]
    }
    var alphaValue: CGFloat{
        return cgColor.components! [3]
    }
    
}

extension ViewController:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let checkNumbers = { (textField: UITextField, slider: UISlider, label: UILabel)->(CGFloat?) in
            
            guard var number = Float(textField.text!) else { return  nil}
            
            if number > 255 {
                number = 255
            }
            else if number < 0 {
                number = 0
            }
            
            textField.text = String(number)
            slider.value = number
            label.text = String(number)
            
            return CGFloat(number)
        }
        
        guard let id = textField.accessibilityIdentifier else {return}
        switch id {
            case "RedTF":
                guard let redValueSelf = checkNumbers(redValueTextField, sliderRed, redValueLabel) else { return }
                redValue = redValueSelf/255
            
            case "GreenTF":
                guard let greenValueSelf = checkNumbers(greenValueTextField, sliderGreen, greenValueLabel) else { return }
                greenValue = greenValueSelf/255
            case "BlueTF":
                guard let blueValueSelf = checkNumbers(blueValueTextField, sliderBlue, blueValueLabel) else { return }
                blueValue = blueValueSelf/255
            default:
                print("default")
        }
        colorPalette.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
    }
}
