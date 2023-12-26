//
//  AllSurahsVC.swift
//  pray times
//
//  Created by Omar barkat on 12/12/2023.
//

import UIKit

class AllSurahsVC: UIViewController {

    var arrSurahsData : [dataa] = []
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        timesAPI.getAllSurahs { response in
            self.arrSurahsData.append(contentsOf: response)
            self.collectionView.reloadData()
//            print(response)
        }
        
    }
    
}
extension AllSurahsVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSurahsData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SurahsCell
        let currentCell = arrSurahsData[indexPath.row]
        cell.lblSuraName.text = currentCell.name
        cell.lblSurahsNumbers.text = "\(currentCell.numberOfAyahs)"
        cell.lblNumbers.text = "\(currentCell.number)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = arrSurahsData[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "Quran") as! QuranBySurahVC
        vc.arrayahs = selectedCell
        let numberSurah = selectedCell.number
        present(vc, animated: true, completion: nil)
    }
    
}
