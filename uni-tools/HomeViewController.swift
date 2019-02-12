//
//  HomeViewController.swift
//  uni-tools
//
//  Created by Grant Wei on 12/1/19.
//  Copyright © 2019 Grant Wei. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var classroomButton: UIButton!
    @IBOutlet var enrolmentButton: UIButton!
    var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courses = getFollowedCourses()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("HOME VC viewdidappear")

//        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    func getFollowedCourses() -> [Course] {
        var courses: [Course] = []
        
        print("first")
        if let followedCourses = PFUser.current()!["followedCourses"] as? [String] {
            print("swifty")
            for course in followedCourses {
                let newCourse = Course(title: course)
                courses.append(newCourse)
            }
        }

        return courses
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout", preferredStyle: .alert)
    
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            PFUser.logOut()
            self.performSegue(withIdentifier: "logoutSegue", sender: self)
            print("logout")
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func classroomClicked(_ sender: Any) {
    }
    
    @IBAction func enrolmentClicked(_ sender: Any) {
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let course = courses[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell") as! CourseCell
        cell.setCourse(course: course)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
//
//        }
//        deleteAction.backgroundColor = .red
//        return [deleteAction]
//    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        removeCourse(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.courses.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        return action
    }
    
    func removeCourse(at indexPath: IndexPath) {
        let course = courses[indexPath.row]
        let courseTitle = course.title
        
        if var followedCourses = PFUser.current()!["followedCourses"] as? [String] {
            print(followedCourses)
            followedCourses = followedCourses.filter { $0 != courseTitle }
            print(followedCourses)
            PFUser.current()?.setObject(followedCourses, forKey: "followedCourses")
            PFUser.current()?.saveInBackground { (success: Bool, error: Error?) in
                if (success) {
                    print("success")
                } else {
                    print("failed")
                }
            }
        }
    }
    
}
