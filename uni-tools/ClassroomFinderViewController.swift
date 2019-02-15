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
    
    var startTime: String?
    var endTime: String?
    var day: String?
    var building: String?
    var htmlResponse: String?
    
    @IBAction func searchRooms(_ sender: Any) {
        let completion = { (result: String) in  (self.htmlResponse = result) }
        postRequest(completionHandler: completion)
        
        // temporary fix
        // *figure out how to segue after completion*
        repeat {
            
        } while htmlResponse == nil
        
        performSegue(withIdentifier: "ClassList", sender: self)
    }
    
    // Source:
    // https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method
    func postRequest(completionHandler: @escaping (String) -> ()) {
        let url = URL(string: "https://nss.cse.unsw.edu.au/tt/find_rooms.php?dbafile=2018-KENS-COFA.DBA&campus=KENS")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        if day == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            day = dateFormatter.string(from: Date())
        }
        
        var postString = "RU[]=RU_GP-TUTSEM&search_rooms=Search"
        
        if day != nil && day != "None Selected" {
            postString = "days[]=" + day! + "&" + postString
        }
        
        if building != nil  && building != "None Selected" {
            let buildingId = buildingsMap[building!]
            postString = "PR[]=" + buildingId! + "&" + postString
        }
        
        if startTime != nil && startTime != "None Selected" {
            let time = startTime!.components(separatedBy: ":")
            postString = "fr_time=" + String(Int(time[0])! * 2) + "&" + postString
        }
        
        if endTime != nil && endTime != "None Selected" {
            let time = endTime!.components(separatedBy: ":")
            postString = "to_time=" + String(Int(time[0])! * 2) + "&" + postString
        }
        
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
            completionHandler(responseString!);
        }
        task.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let classListVC = segue.destination as! ClassroomList
        classListVC.html = htmlResponse
    }
    
    var times = ["None Selected", "08:00", "09:00", "10:00", "11:00", "12:00",
                 "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00",
                 "20:00", "21:00", "22:00"]
    var days = ["None Selected", "Monday", "Tuesday", "Wednesday", "Thursday",
                "Friday", "Saturday", "Sunday"]
    
    // add buildings
    var buildings = ["None Selected", "ADFA Campus", "Ainsworth Building", "Arts and Design", "Biological Science", "Central Lecture Block", "Chemical Sciences", "Civil Engineering", "College of Fine Arts", "Colombo", "Computer Science and Eng", "Electrical Engineering", "Goldstein", "Heffron Building", "Huts", "John Goodsell", "Law", "Library Stage 2", "Materials Science", "Mathews", "Morven Brown", "Old Main Building", "Quadrangle", "Red Centre East", "Red Centre West", "Rupert Myers", "Samuels", "Square House", "Tyree Energy Technology Building", "UNSW Business School", "Webster", "Western Grounds", "Wurth"]
    
    var buildingsMap = [
        "None Selected": "",
        "ADFA Campus": "PR_ADFA",
        "Ainsworth Building": "PR_MECH",
        "Arts and Design": "PR_ART&DES",
        "Biological Science": "PR_BIOSCI",
        "Central Lecture Block": "PR_CLB",
        "Chemical Sciences": "PR_APPSCI",
        "Civil Engineering": "PR_CIVIL",
        "College of Fine Arts": "PR_COFA",
        "Colombo": "PR_COLOMBO",
        "Computer Science and Eng": "PR_CSEK17",
        "Electrical Engineering": "PR_ELEC",
        "Goldstein": "PR_GOLD",
        "Heffron Building": "PR_HEFFRON",
        "Huts": "PR_HUTS",
        "John Goodsell": "PR_GOODSL",
        "Law": "PR_LAW",
        "Library Stage 2": "PR_LIBSTG2",
        "Materials Science": "PR_MATSCI",
        "Mathews": "PR_MATHEWS",
        "Morven Brown": "PR_MORVENBRN",
        "Old Main Building": "PR_OLDMAIN",
        "Quadrangle": "PR_QUAD",
        "Red Centre East": "PR_REDC-E",
        "Red Centre West": "PR_REDC-W",
        "Rupert Myers": "PR_MYERS",
        "Samuels": "PR_SAM",
        "Square House": "PR_SQHS",
        "Tyree Energy Technology Building": "PR_TETB",
        "UNSW Business School": "PR_ASB",
        "Webster": "PR_WEBSTER",
        "Western Grounds": "PR_WESTGD",
        "Wurth": "PR_WURTH"
    ]
    
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
        
        currentBox.inputView = pickerView
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
