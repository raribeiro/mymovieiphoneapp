//
//  UIViewController+CoreData.swift
//  MyMovie
//
//  Created by Rodnei Albuquerque on 19/03/23.
//

import UIKit
import CoreData

extension UIViewController {
    
    //Esta variável computada nos dará acesso ao NSManagedObjectContext a partir de qualquer tela
    var context: NSManagedObjectContext {
        
        //Aqui estamos criando uma referência ao AppDelegate
        let appDelegate = UIApplication.shared.delegate
             as! AppDelegate
        

        //Conseguimos acessar o NSManagedObjectContext a partir da propriedade .viewContext presente em nosso persistentContainer. Aqui apenas retornamos essa propriedade.
        return appDelegate.persistentContainer.viewContext
    }
}
