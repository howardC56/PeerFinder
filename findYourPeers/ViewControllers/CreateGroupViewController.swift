//
//  CreateGroupViewController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import Kingfisher

class CreateGroupViewController: UIViewController {
    
    let customBlueColor = UIColor(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    
    let customGoldColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    
    private let groupView = CreateViewGroup()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    private var selectedImage: UIImage? {
        didSet {
            groupView.imageView.image = selectedImage
        }
    }
    
    private var selectedCategory: String = "study"
    
    override func loadView() {
        view = groupView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupView.groupTopicTextField.delegate = self
        groupView.groupTopicTextField.delegate = self
        groupView.descriptionTextView.delegate = self
        
        groupView.changeImageButton.addTarget(self, action: #selector(addImage(_:)), for: .touchUpInside)
        
        groupView.categorySegmentedControl.addTarget(self, action: #selector(segmentedControllerPressed(_:)), for: .valueChanged)
        
        configureNavBar()
    }

    
    @objc
    private func addImage(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default)
        {[weak self] alertAction in self?.imagePickerController.sourceType = .camera
            self?.present(self!.imagePickerController, animated: true)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) {[weak self] alertAction in self?.imagePickerController.sourceType = .photoLibrary
            self?.present(self!.imagePickerController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func configureNavBar() {
        navigationItem.title = "Create Group"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: customBlueColor,
            NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 20.0) as Any]
        
       // UINavigationBar.appearance().title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(createGroupButtonPressed))
       navigationItem.rightBarButtonItem?.tintColor = customBlueColor
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 20.0)!], for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = customBlueColor
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 20.0)!], for: .normal)
    }
    
    @objc private func segmentedControllerPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedCategory = "study"
        case 1:
            selectedCategory = "club"
        case 2:
            selectedCategory = "event"
        default:
            break
        }
    }
    
    @objc private func createGroupButtonPressed(_ sender: UIBarButtonItem) {
        
        sender.isEnabled = false
        
        guard let groupName = groupView.groupNameTextField.text, !groupName.isEmpty,
            let topic = groupView.groupTopicTextField.text, !topic.isEmpty,
            let description = groupView.descriptionTextView.text, !description.isEmpty,
            let selectedImage = selectedImage else {
                showAlert(title: "Missing Fields", message: "All fields are required along with a photo.")
                sender.isEnabled = true
                return
        }
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: groupView.imageView.bounds)
        
        let category = self.selectedCategory
        let collegeName = "City College"
        let createdBy = "Antonio Flores"
        let creatorId = "6cy5BFsR14xyjGXWBvDq"
        let dateCreated = Date()
        let id = UUID().uuidString
        
        var groupPhotoURL = String()
        FireBaseStorage.shared.uploadPhoto(groupID: id, itemID: nil, image: resizedImage) { (result) in
            switch result {
            case .failure(let error):
                print("failed to upload photo: \(error.localizedDescription)")
            case .success(let URL):
                let imageURL = URL
                groupPhotoURL = imageURL.absoluteString
                let newGroup = Group(category: category, collegeName: collegeName, createdBy: createdBy, creatorId: creatorId, dateCreated: dateCreated, description: description, id: id, groupName: groupName, groupPhotoURL: groupPhotoURL, topic: topic)
                self.createNewGroup(group: newGroup)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func createNewGroup(group: Group) {
        DatabaseService.manager.createGroup(group)
        { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error creating group.", message: "Sorry something went wrong: \(error.localizedDescription)")
                }
            case .success:
                print("successfully added group to Firebase")
            }
        }
    }
    
    private func clearAllFields() {
        groupView.groupNameTextField.text = nil
        groupView.groupNameTextField.placeholder = "Enter Name For Group"
        groupView.groupTopicTextField.text = nil
        groupView.groupTopicTextField.placeholder = "Enter Topic For Group"
        groupView.descriptionTextView.text = "Enter Description For Group"
        groupView.descriptionTextView.textColor = UIColor.lightGray
        groupView.categorySegmentedControl.selectedSegmentIndex = 0
        groupView.imageView.image = UIImage(systemName: "photo.fill")
    }
    
    @objc private func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension CreateGroupViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter Description For Group" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            groupView.descriptionTextView.text = "Enter Description For Group"
            groupView.descriptionTextView.textColor = UIColor.lightGray
            groupView.descriptionTextView.font = UIFont(name: "Kohinoor Telugu", size: 20.0)
        }
    }
}

extension CreateGroupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        selectedImage = image
        dismiss(animated: true, completion: nil)
    }
}
