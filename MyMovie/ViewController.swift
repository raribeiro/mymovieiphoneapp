//
//  ViewController.swift
//  MyMovie
//
//  Created by Rodnei Albuquerque on 18/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    var movie: Movie?
    
    var trailer: String = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var summaryText: UITextView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            posterImage.image = movie.image as? UIImage
            titleLabel.text = movie.title
            categoryLabel.text = movie.categories
            summaryText.text = movie.summary
            durationLabel.text = movie.duration
        }
        
        if let title = movie?.title {
            loadTrailers(title: title)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? AddEditViewController {
          vc.movie = movie
      }
    }
    
    func loadTrailers(title: String) {
       
       //Chamamos o método loadTrailers da classe API e na
       //closure vamos recuperar o primeiro resultado da
       //lista de resultados.
       API.loadTrailers(title: title) { (apiResult) in
           guard let results = apiResult?.results, let trailer = results.first else {return}
           
           //Aqui, pegamos a url do trailer e atribuímos à
           //nossa variável trailer, fazendo na thread main.
           DispatchQueue.main.async {
               self.trailer = trailer.previewUrl
               print("URL do Trailer:", trailer.previewUrl)
           }
       }
    }
    
    

}

