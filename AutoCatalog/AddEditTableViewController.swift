//
//  AddEditTableViewController.swift
//  AutoCatalog
//
//  Created by Georgy Dyagilev on 04/03/2019.
//  Copyright © 2019 Georgy Dyagilev. All rights reserved.
//

import UIKit

class AddEditTableViewController: UITableViewController {
    
    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var carTypeTextField: UITextField!
    @IBOutlet weak var carClassTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var pickerView = UIPickerView()
    var currentTextField = UITextField()
    var car: Car?
    var addFlag = true
    var pickerData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPickerView))
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        carTypeTextField.delegate = self
        carTypeTextField.inputView = pickerView
        carTypeTextField.inputAccessoryView = toolBar
        carTypeTextField.tintColor = UIColor.clear
        
        carClassTextField.delegate = self
        carClassTextField.inputView = pickerView
        carClassTextField.inputAccessoryView = toolBar
        carClassTextField.tintColor = UIColor.clear
        
        yearTextField.inputAccessoryView = toolBar
        
        updateUI()
        updateSaveButtonState()
        
        tableView.tableFooterView = UIView()
    }
    
    func updateUI() {
        if let car = car {
            manufacturerTextField.text = car.manufacturer
            modelTextField.text = car.model
            carTypeTextField.text = car.carType.rawValue
            carClassTextField.text = car.carClass.rawValue
            yearTextField.text = "\(car.year)"
        }
    }
    
    func updateSaveButtonState() {
        if (manufacturerTextField.text?.isEmpty)! || (modelTextField.text?.isEmpty)! || (carTypeTextField.text?.isEmpty)! || (carClassTextField.text?.isEmpty)! || (yearTextField.text?.isEmpty)! {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    @objc func dismissPickerView() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveUnwind" && addFlag == false {
            car!.manufacturer = manufacturerTextField.text!
            car!.model = modelTextField.text!
            car!.carType = CarType(rawValue: carTypeTextField.text!)!
            car!.carClass = CarClass(rawValue: carClassTextField.text!)!
            car!.year = Int(yearTextField.text!)!
        }
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func carTypeTapped() {
        pickerData = CarType.allCases.map({ (carType) -> String in
            return carType.rawValue
        })
        currentTextField = carTypeTextField
    }
    
    @IBAction func carClassTapped() {
        pickerData = CarClass.allCases.map({ (carClass) -> String in
            return carClass.rawValue
        })
        currentTextField = carClassTextField
    }    
}

extension AddEditTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == carTypeTextField {
            carTypeTextField.text = pickerData[row]
        } else if currentTextField == carClassTextField {
            carClassTextField.text = pickerData[row]
        }
    }
}

extension AddEditTableViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == carTypeTextField || textField == carClassTextField {
            return false
        }
        return true
    }
}

