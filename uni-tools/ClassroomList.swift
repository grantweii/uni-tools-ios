//
//  ClassroomList.swift
//  uni-tools
//
//  Created by allanski on 7/2/19.
//  Copyright © 2019 Grant Wei. All rights reserved.
//

import UIKit

class ClassroomList: UIViewController {

    var html: String?
    @IBOutlet weak var output: UITextView!
    override func viewDidLoad() {
        if let receivedText = html {
            let regex = try! NSRegularExpression(pattern: " {8}<td class=\"data\">([^<]*)", options: [])
            
            let matches = regex.matches(in: receivedText, options: [], range: NSRange(location: 0, length: receivedText.count))
            
            var count: Int = 0
            // if count == 0 -> matchString contains the room
            // if count == 1 -> matchString contains the description
            // put this data into the frontend layout
            // just in a textfield atm 
            var result: String = ""
            for match in matches {
                if (count > 1) {
                    count += 1
                    if (count == 6) {
                        count = 0
                    }
                    continue
                }
                let range = match.range
                var matchString = (receivedText as NSString).substring(with: range)
                matchString = String(matchString.dropFirst(25))
                
                // tmp until table gets created
                if (count == 0) {
                    result += "Room: "
                    result += matchString
                    result += "\nDescription: "
                }
                if (count == 1) {
                    result += matchString
                    result += "\n\n"
                }
                
                count += 1
            }
            
            output.text = result
        }

        // Do any additional setup after loading the view.
    }


}
