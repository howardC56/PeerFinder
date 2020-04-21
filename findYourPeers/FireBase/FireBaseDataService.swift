//
//  FireBaseDataService.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class DatabaseService {
  static let manager = DatabaseService()
  static let userCollection = "users"
  static let groupsCollection = "groups"
  static let postsCollection = "posts"
  static let favoriteGroupsCollection = "favoriteGroups"
  private let db = Firestore.firestore()
  private init () {}
    
    
    public func createGroup<T: Codable & Identifiable>(_ item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        let document = db.collection(DatabaseService.groupsCollection).document(item.id as! String)
        do {
            try document.setData(from: item)
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    public func deleteGroup<T: Codable & Identifiable>(_ item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
            db.collection(DatabaseService.groupsCollection).document(item.id as! String).delete { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(true))
                    }
        }
    }
    
    public func getGroups<T: Codable>(item: T.Type, completion: @escaping (Result<[T], Error>) -> ()) {
        db.collection(DatabaseService.groupsCollection).getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let snapshot = snapshot {
                    let items = snapshot.documents.compactMap { try? $0.data(as: T.self) }
                    completion(.success(items))
        }
    }
    }

    public func addGroupToFavorties<T: Codable & Identifiable>(_ item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        let document = db.collection(DatabaseService.favoriteGroupsCollection).document(item.id as! String)
        do {
            try document.setData(from: item)
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    public func deleteGroupFromFavorites<T: Codable & Identifiable>(_ item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
            db.collection(DatabaseService.favoriteGroupsCollection).document(item.id as! String).delete { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(true))
                    }
        }
    }
    
    public func groupIsFavorited<T: Codable & Identifiable>(_ item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        db.collection(DatabaseService.favoriteGroupsCollection).whereField("id", isEqualTo: item.id as! String).getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let snapshot = snapshot {
                    let count = snapshot.documents.count
                    if count > 0 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                }
        }
    }
    
    public func getFavoriteGroups<T: Codable>(item: T.Type, completion: @escaping (Result<[T], Error>) -> ()) {
        db.collection(DatabaseService.favoriteGroupsCollection).getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let snapshot = snapshot {
                    let items = snapshot.documents.compactMap { try? $0.data(as: T.self) }
                    completion(.success(items))
        }
    }
    }
    
    public func createPost<T: Codable & Identifiable>(_ item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        let document = db.collection(DatabaseService.postsCollection).document(item.id as! String)
        do {
            try document.setData(from: item)
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }

    
}
