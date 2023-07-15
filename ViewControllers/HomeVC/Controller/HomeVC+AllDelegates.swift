//
//  HomeVC+AllDelegates.swift
//  PrecticalTask
//
//  Created by Abhay Pansora on 15/07/23.
//

import Foundation
import UIKit
/*
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mainView.clnViewOwned{
            return 10
        }
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as! MusicCell
        /*
         cell.setData(data: self.mainModelView.products[indexPath.row])
         */
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let availableWidth = collectionView.bounds.width - (15 * (numberOfColumns - 1))
        let itemWidth = availableWidth / numberOfColumns
        return CGSize(width: itemWidth, height: 215)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*let VC = DetailsVC(nibName: "DetailsVC", bundle: nil)
        if self.mainModelView.isFilter{
            VC.mainModelView.objProduct = self.mainModelView.filterProduct[indexPath.row]
        }else{
            VC.mainModelView.objProduct = self.mainModelView.products[indexPath.row]
        }
        self.navigationController?.pushViewController(VC, animated: true)*/
    }
}
*/
