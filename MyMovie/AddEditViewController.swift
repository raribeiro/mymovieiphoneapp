//
//  AddEditViewController.swift
//  MyMovies
//
//  Created by Eric Brito on 11/06/2018.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    //Variável que receberá o filme selecionado.
    var movie: Movie?
    
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfCategories: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tvSummary: UITextView!
    @IBOutlet weak var btAddEdit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            ivMovie.image = movie.image as? UIImage
            tfTitle.text = movie.title
            tfCategories.text = movie.categories
            tfDuration.text = movie.duration
            tfRating.text = "⭐️ \(movie.rating)/10"
            tvSummary.text = movie.summary
            
            //Alterando o texto do botão caso existe um filme
            btAddEdit.setTitle("Alterar", for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with
      event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func addEditMovie(_ sender: UIButton) {
        //Se o movie for nulo é sinal que estamos criando um filme e portanto vamos instanciar um novo Movie. Como é uma classe Core Data, instanciamos passando o context.
        if movie == nil {
            movie = Movie(context: context)
        }
        
        //Passamos para o movie os valores dos campos
        movie?.title = tfTitle.text
        movie?.categories = tfCategories.text
        movie?.duration = tfDuration.text
        movie?.rating = Double(tfRating.text!) ?? 0
        movie?.image = ivMovie.image
        movie?.summary = tvSummary.text
        
        do {
            //O método abaixo salva qualquer alteração ocorrida no contexto, ou seja, altera o filme ou grava um novo.
            try context.save()
            
            //O comando abaixo solicita à Navigaton Controller que retorne à tela anterior.
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}
