//
//  ViewController.swift
//  MovieS
//
//  Created by Berke Ersiz on 8.02.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var kategoriTableView: UITableView!
    
    var kategorilerListe = [Kategoriler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kategoriTableView.delegate = self
        kategoriTableView.dataSource = self
        
        tumKategorilerAl()
    }
    
    func tumKategorilerAl(){
        AF.request("http://kasimadalan.pe.hu/filmler/tum_kategoriler.php",method: .get).response{
            response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(KategoriCevap.self, from: data)
                    if let gelenKategoriListei = cevap.kategoriler {
                        self.kategorilerListe = gelenKategoriListei
                    }
                    DispatchQueue.main.async {
                        self.kategoriTableView.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int //Downcasting ? işareti ile ise nil olur.
        let gidilecekVC = segue.destination as! FilmViewController//Downcasting ! ileyse hata verir.
        gidilecekVC.kategori = kategorilerListe[indeks!]
    }


}


extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategorilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kategori = kategorilerListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategoriCell", for: indexPath) as! KategoriTableViewCell
        
        cell.labelKategoriAd.text = kategori.kategori_ad
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFilm", sender: indexPath.row)
    }
}

