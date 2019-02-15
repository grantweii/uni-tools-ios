//
//  EnrolmentFinderViewController.swift
//  uni-tools
//
//  Created by Grant Wei on 12/1/19.
//  Copyright © 2019 Grant Wei. All rights reserved.
//

import UIKit

class EnrolmentFinderViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var currentBox = UITextField()
    var pickerView = UIPickerView()
    
    var faculty: String?
    var semester: String?

    var faculties = ["None Selected", "ACCT", "ACTL", "AERO", "ANAT", "ARCH", "ARTS", "ATSI", "AVEN", "AVIA", "AVIF", "AVIG", "BABS", "BEES", "BEIL", "BENV", "BINF", "BIOC", "BIOM", "BIOS", "BLDG", "CEIC", "CHEM", "CHEN", "CLIM", "CODE", "COMD", "COMM", "COMP", "CONS", "CRIM", "CVEN", "DATA", "DIPP", "ECON", "EDST", "ELEC", "ENGG", "EXCH", "FINS", "FNDN", "FOOD", "GENC", "GENL", "GENM", "GENS", "GENY", "GEOS", "GMAT", "GSOE", "HDAT", "HESC", "HUMS", "IDES", "IEST", "INFS", "INST", "INTA", "JURD", "LAND", "LAWS", "LING", "MANF", "MARK", "MATH", "MATS", "MBAX", "MDCN", "MDIA", "MECH", "MFAC", "MFIN", "MGMT", "MICR", "MINE", "MMAN", "MMGT", "MNGT", "MNNG", "MODL", "MSCI", "MTRN", "MUPS", "MUSC", "NANO", "NEUR", "OPTM", "PATH", "PHAR", "PHCM", "PHOP", "PHSL", "PHTN", "PHYS", "PLAN", "POLS", "POLY", "PPEC", "PSCY", "PSYC", "PTRL", "REGZ", "REST", "RISK", "SCIF", "SENG", "SOCF", "SOCW", "SOLA", "SOMS", "SRAP", "SUSD", "SWCH", "TABL", "TELE", "UDES", "VISN", "YENG", "YMED", "ADAD", "DART", "DDES", "SAHT", "SART", "SDES", "SOMA", "ZBUS", "ZEIT", "ZGEN", "ZHSS", "ZINT", "ZPEM"]
    
    var semesters = ["None Selected", "Summer", "T1", "T2", "T3"]
    
    @IBOutlet weak var facultyBox: UITextField!
    @IBOutlet weak var semesterBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func searchEnrolments(_ sender: Any) {
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentBox == facultyBox {
            return faculties.count
        }
        else if currentBox == semesterBox {
            return semesters.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if currentBox == facultyBox {
            return faculties[row]
        }
        else if currentBox == semesterBox {
            return semesters[row]
        }
        else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if currentBox == facultyBox {
            faculty = faculties[row]
            facultyBox.text = faculty
        }
        else if currentBox == semesterBox {
            semester = semesters[row]
            semesterBox.text = semester
        }
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        if currentBox == facultyBox {
            facultyBox.inputAccessoryView = toolBar
        }
        else if currentBox == semesterBox {
            semesterBox.inputAccessoryView = toolBar
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
