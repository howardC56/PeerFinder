//
//  MarketPlaceViewController.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class MarketPlaceViewController: UIViewController {

    private let marketPlaceView = MarketPlaceView()
    
    override func loadView() {
        view = marketPlaceView
        view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()

    }
    private func configureCollectionView(){
        marketPlaceView.collectionView.delegate = self
        marketPlaceView.collectionView.dataSource = self
        marketPlaceView.collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "itemCell")
    }
    

}
extension MarketPlaceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width * 0.9
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
extension MarketPlaceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = marketPlaceView.collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? ItemCell else {
            fatalError("failed to cast to ItemCell")
        }
        cell.backgroundColor = #colorLiteral(red: 0.9971715808, green: 0.8923018575, blue: 0.4402516186, alpha: 1)
        return cell
    }
    
    
}
