//
//  FilmViewController.swift
//  MovieS
//
//  Created by Berke Ersiz on 9.02.2023.
//

import UIKit
import Alamofire

class FilmViewController: UIViewController {

    @IBOutlet weak var filmCollectionView: UICollectionView!
    
    var filmListesi = [Filmler]()
    var kategori:Kategoriler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmCollectionView.delegate = self
        filmCollectionView.dataSource = self
        //****************************************************************************************************
        let tasarim :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let genislik = self.filmCollectionView.frame.size.width
        
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let hucreGenislik = (genislik-30)/2
        
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.7)
        
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        filmCollectionView.collectionViewLayout = tasarim
        //****************************************************************************************************
        if let k = kategori {//kategori gelirse if letin içine girer.
            if let kId = Int(k.kategori_id!) { //String yapısından inte çevirirken iflet kullanmalıyız!
                
                navigationItem.title = k.kategori_ad
                filmlerByKategoriID(kategori_id:kId)
                
            }
        }
    }
    
    func filmlerByKategoriID(kategori_id:Int){
        
        let parametre:Parameters = ["kategori_id":kategori_id]//post oldugu için parametremizi yollıyacagız.
        AF.request("http://kasimadalan.pe.hu/filmler/filmler_by_kategori_id.php",method: .post,parameters: parametre).response{
            response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(FilmCevap.self, from: data)
                    if let gelenFilmListesi = cevap.filmler {
                        self.filmListesi = gelenFilmListesi
                    }
                    DispatchQueue.main.async { //thread oluşturmamızın sebebi ui hemen güncellemek.
                        self.filmCollectionView.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int //Downcasting ? işareti ile ise nil olur.
        let gidilecekVC = segue.destination as! FilmDetayViewController//Downcasting ! ileyse hata verir.
        gidilecekVC.film = filmListesi[indeks!]
    }
    

  

}


extension FilmViewController:UICollectionViewDelegate,UICollectionViewDataSource,FilmHucreCollectionViewCellProtocol{
    
    func sepeteEkle(indexPath: IndexPath) {
        print("Sepete Eklenen Film : \(filmListesi[indexPath.row].film_ad!)")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let film = filmListesi[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as! FilmCollectionViewCell
        
        cell.labelFilmAdi.text = film.film_ad
        cell.labelFilmFiyat.text = "14.99 TL"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(film.film_resim!)"){//Unlem koymazsak string değil optional!!
            DispatchQueue.global().async {//sebebi datayı almak
                let data = try? Data(contentsOf: url)//sdocatch yerine tryla kontrol da yapabiliriz, data yoksa nil göstericektir.
                
                DispatchQueue.main.async {//arayüzdeki görsel nesnelere bir şey eklemek istiyorsak dispatchqueue mecbur.
                    cell.filmImage.image = UIImage(data: data!)
                    cell.filmImage.layer.cornerRadius = CGRectGetWidth(cell.filmImage.frame)/3.0
                }
            }
        }
        
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        cell.hucreProtocol = self
        cell.indexPath = indexPath
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
        //burda tıklanılan satırın indeksiz neyse prepare fonksiyonunda detay sayfasına gönderilecek.
    }
}
