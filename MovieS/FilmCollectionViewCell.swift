//
//  FilmCollectionViewCell.swift
//  MovieS
//
//  Created by Berke Ersiz on 9.02.2023.
//

import UIKit

protocol FilmHucreCollectionViewCellProtocol {
    func sepeteEkle(indexPath:IndexPath)
}


class FilmCollectionViewCell: UICollectionViewCell {
    
    var hucreProtocol:FilmHucreCollectionViewCellProtocol?
    var indexPath:IndexPath?
    
    @IBOutlet weak var filmImage: UIImageView!
    
    @IBOutlet weak var labelFilmAdi: UILabel!
    
    
    @IBOutlet weak var labelFilmFiyat: UILabel!
    
    
    @IBAction func sepeteEkle(_ sender: UIButton) {
    }
}
