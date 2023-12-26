//
//  QuranBySurahVC.swift
//  pray times
//
//  Created by Omar barkat on 10/12/2023.
//

import UIKit
import NVActivityIndicatorView

class QuranBySurahVC: UIViewController {
    
    var arrAyaData : [ayahs] = []
    var arrayahs : dataa!
    var arrSurah : quraan!
    var suraName : String = ""
    @IBOutlet weak var loaderIndecatorView: NVActivityIndicatorView!
    @IBOutlet weak var lblAyahsNumbers: UILabel!
    @IBOutlet weak var lblJuzNumber: UILabel!
    @IBOutlet weak var lblSurahName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loaderIndecatorView.startAnimating()
        timesAPI.getQuraanBySurah(number: arrayahs.number, offset: 0, limit: 10) {ayahData,suraData in
            self.arrAyaData.append(contentsOf: ayahData)
            self.suraName.append(suraData.data.name)
            self.lblSurahName.text = suraData.data.name
            self.lblAyahsNumbers.text = "\(suraData.data.numberOfAyahs)"
            let juz = suraData.data.ayahs![0]
            self.lblJuzNumber.text = "\(juz.juz)"
            self.collectionView.reloadData()
            self.loaderIndecatorView.isHidden = true
            
        }
        }
    }

extension QuranBySurahVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAyaData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"QuraanCell", for: indexPath) as! QuraanCell
        let currentCell = arrAyaData[indexPath.row]
    
            print(currentCell)
        cell.lblSurahTxtBody.text = currentCell.text
            print(currentCell.text)
            cell.lblSuraNumber.text = "(\(currentCell.numberInSurah))"
        print(currentCell.numberInSurah)
        return cell
        
    }
}
    

   


