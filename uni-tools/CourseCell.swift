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

}
