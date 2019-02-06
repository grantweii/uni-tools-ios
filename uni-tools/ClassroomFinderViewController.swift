//
//  ClassroomViewController.swift
//  uni-tools
//
//  Created by Grant Wei on 12/1/19.
//  Copyright © 2019 Grant Wei. All rights reserved.
//

import UIKit

class ClassroomFinderViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var currentBox = UITextField()
    var pickerView = UIPickerView()
    
    @IBOutlet weak var startBox: UITextField!
    @IBOutlet weak var endBox: UITextField!
    @IBOutlet weak var dayBox: UITextField!
    @IBOutlet weak var buildingBox: UITextField!
    
    var startTime : String?
    var endTime: String?
    var day: String?
    var building: String?
    
    var times = ["08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00",
                 "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00"]
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                "Saturday", "Sunday"]
    
    // add buildings
    var buildings = ["test1", "test2", "test3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentBox == startBox || currentBox == endBox {
            return times.count
        }
        else if currentBox == dayBox {
            return days.count
        }
        else if currentBox == buildingBox {
            return buildings.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if currentBox == startBox || currentBox == endBox {
            return times[row]
        }
        else if currentBox == dayBox {
            return days[row]
        }
        else if currentBox == buildingBox {
            return buildings[row]
        }
        else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if currentBox == startBox {
            startTime = times[row]
            startBox.text = startTime
        }
        else if currentBox == endBox {
            endTime = times[row]
            endBox.text = endTime
        }
        else if currentBox == dayBox {
            day = days[row]
            dayBox.text = day
        }
        else if currentBox == buildingBox {
            building = buildings[row]
            buildingBox.text = building
        }
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        if currentBox == startBox {
            startBox.inputAccessoryView = toolBar
        }
        else if currentBox == endBox {
            endBox.inputAccessoryView = toolBar
        }
        else if currentBox == dayBox {
            dayBox.inputAccessoryView = toolBar
        }
        else if currentBox == buildingBox {
            buildingBox.inputAccessoryView = toolBar
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentBox = textField
        
        if currentBox == startBox {
            currentBox.inputView = pickerView
        }
        else if currentBox == endBox {
            currentBox.inputView = pickerView
        }
        else if currentBox == dayBox {
            dayBox.inputView = pickerView
        }
        else if currentBox == buildingBox {
            buildingBox.inputView = pickerView
        }
        
        dismissPickerView()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
