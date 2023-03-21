//
//  MovieViewControllerTableViewController.swift
//  MyMovie
//
//  Created by Rodnei Albuquerque on 18/03/23.
//

import UIKit
import CoreData

class MovieViewControllerTableViewController: UITableViewController {

    //Criamos o objeto NSFetchedResultsController definindo que será um controller da entidade Movie
    var fetchedResultsController: NSFetchedResultsController<Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadMovies()
    }
    
    func loadMovies (){
        
        //O objeto fetchRequest é responsável por fazer uma leitura dos itens do Core Data. Criamos um fetchRequest de Movie pois queremos buscar todos os filmes da base. A classe Movie (gerada pelo Core Data) já possui um método que nos retorna seu fetchRequest
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        //Abaixo, definimos que os filmes serão ordenados em ordem alfabética pelo título
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //Instanciando objeto fetchedResultsController. Aqui precisamos passar o fetchRequest e o contexto do Core Data.
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        //Definimos que esta classe será delegate do fetchedResultsController. Ela que será chamada quando algo acontecer no contexto dos filmes
        fetchedResultsController.delegate = self
        
        do{
            //Executando a requisição de movies
            try fetchedResultsController.performFetch()
            
        }catch{
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Os filmes estarão presentes no objeto fetchedObjects. Verificamos se tem filmes e caso não tenha retornamos 0
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            let movie = fetchedResultsController.object(at:tableView.indexPathForSelectedRow!)
            
            viewController.movie = movie;
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //as! MovieViewCell estou indicando Xcode reconhecer a célula customizada.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMovies", for: indexPath) as! MovieTableViewCell
        let movie = fetchedResultsController.object(at: indexPath)
        
        cell.movieTitle.text = movie.title
        cell.summary.text = movie.summary
        cell.posterImage.image = movie.image as? UIImage

        // Configure the cell...

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie =  fetchedResultsController.object(at: indexPath)
            
            context.delete(movie)
            
            do {
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
}

//Através de extensions, vamos implementar o protocolo NSFetchedResultsControllerDelegate para que esta classe possa ser delegate do objeto fetchedResultsControllerDelegate
extension MovieViewControllerTableViewController: NSFetchedResultsControllerDelegate {
    
    //O método abaixo é chamado sempre que alguma alteração é feita em algum filmes. Quando isto ocorrer, iremos fazer o reload da tabela, assim ela recarrega todos os filmes e atualiza seu conteúdo.
    func controllerDidChangeContent(_ controller:
          NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
