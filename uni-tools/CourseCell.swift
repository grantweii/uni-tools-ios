//
//  CourseCell.swift
//  uni-tools
//
//  Created by Grant Wei on 14/1/19.
//  Copyright © 2019 Grant Wei. All rights reserved.
//

import UIKit
import Parse

class CourseCell: UITableViewCell {

    @IBOutlet var courseTitleLabel: UILabel!
    
    func setCourse(course: Course) {
        courseTitleLabel.text = course.title
    }
    
//    func createAlert(title: String, message: String) -> Bool {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action) in return true
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (action) in return false
//        }))
//        present(alert, animated: true, completion: nil)
//    }
    
}
