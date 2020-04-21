//
//  CreateGroupViewController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CreateGroupViewController: UIViewController {
    
    private let groupView = CreateViewGroup()
    
    
    
    override func loadView() {
           view = groupView
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        groupView.groupTopicTextField.delegate = self
        groupView.groupTopicTextField.delegate = self
        groupView.descriptionTextView.delegate = self
        
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Create Group"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(createGroupButtonPressed))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
    }
    
    @objc private func createGroupButtonPressed() {
        
    }
    
    @objc private func cancelButtonPressed() {
        groupView.groupNameTextField.text = nil
        groupView.groupNameTextField.placeholder = "Enter Name For Group"
        groupView.groupTopicTextField.text = nil
        groupView.groupTopicTextField.placeholder = "Enter Topic For Group"
        groupView.descriptionTextView.text = "Enter Description For Group"
        groupView.descriptionTextView.textColor = UIColor.lightGray
        groupView.categorySegmentedControl.selectedSegmentIndex = 0
    }
    

}

extension CreateGroupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension CreateGroupViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }
}
