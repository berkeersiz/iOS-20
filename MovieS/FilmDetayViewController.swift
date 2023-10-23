//
//  FilmDetayViewController.swift
//  MovieS
//
//  Created by Berke Ersiz on 9.02.2023.
//

import UIKit

class FilmDetayViewController: UIViewController {

    @IBOutlet weak var filmDetayImage: UIImageView!
    
    @IBOutlet weak var labelFilmAdı: UILabel!
    
    @IBOutlet weak var labelFilmYıl: UILabel!
    
    @IBOutlet weak var labelFilmKategori: UILabel!
    
    
    @IBOutlet weak var labelFilmYonetmen: UILabel!
    
    var film:Filmler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let f = film {
            if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(f.film_resim!)"){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.filmDetayImage.image = UIImage(data: data!)
                        self.filmDetayImage.layer.cornerRadius = CGRectGetWidth(self.filmDetayImage.frame)/10.0
                        //self.filmDetayImage.clipsToBounds = true
                        self.filmDetayImage.layer.shadowColor = UIColor.black.cgColor
                        self.filmDetayImage.layer.shadowRadius = 5.0
                        self.filmDetayImage.layer.shadowOpacity = 0.8
                        self.filmDetayImage.layer.shadowOffset = CGSize(width: 8, height: 8)
                        self.filmDetayImage.layer.masksToBounds = false
                    }
                }
            }
            labelFilmAdı.text = f.film_ad
            labelFilmYıl.text = f.film_yil
            labelFilmKategori.text = f.kategori?.kategori_ad
            labelFilmYonetmen.text = f.yonetmen?.yonetmen_ad

        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
