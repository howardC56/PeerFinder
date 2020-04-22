//
//  FireBaseStorage.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation
import FirebaseStorage

class FireBaseStorage {
    private init() {}
    static let shared = FireBaseStorage()
    private let storageRef = Storage.storage().reference()
    
    public func uploadPhoto(groupID: String? = nil, itemID: String? = nil, image: UIImage, completion: @escaping (Result<URL,Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        var photoReference: StorageReference!
        if let groupID = groupID {
            photoReference = storageRef.child("GroupPhotos/\(groupID).jpg")
        } else if let itemId = itemID {
            photoReference = storageRef.child("ItemsPhotos/\(itemId).jpg")
        }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        let _ = photoReference.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
            } else if let _ = metadata {
                photoReference.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }
            }
        }
    }
    
     public func fetchGroupPhoto(groupID: String, completion: @escaping (Result<URL, Error>) -> ()) {
        storageRef.child("GroupPhotos/\(groupID).jpg").downloadURL { (url, error) in
          if let error = error {
            completion(.failure(error))
          } else if let url = url {
            completion(.success(url))
          }
        }
      }
    
    public func fetchItemPhoto(itemID: String, completion: @escaping (Result<URL, Error>) -> ()) {
      storageRef.child("GroupPhotos/\(itemID).jpg").downloadURL { (url, error) in
        if let error = error {
          completion(.failure(error))
        } else if let url = url {
          completion(.success(url))
        }
      }
    }
    
}
