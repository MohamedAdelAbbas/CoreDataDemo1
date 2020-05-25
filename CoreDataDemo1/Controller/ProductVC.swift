//
//  ProductVC.swift
//  CoreDataDemo1
//
//  Created by Mohamed Adel on 5/25/20.
//  Copyright © 2020 Mohamed Adel. All rights reserved.
//

import UIKit
import CoreData

class ProductVC: UIViewController {
    // MARK: Outlets
    
    @IBOutlet weak var PNameTF: UITextField!
    @IBOutlet weak var pPriceTF: UITextField!
    @IBOutlet weak var switchFav: UISwitch!
    // MARK: Properties
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    // MARK: Action
    
    @IBAction func Insert(_ sender: UIButton) {
        let p = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context) as! Product
       // UserDefaults is Optional so we make ??
        p.pID = Int32((UserDefaults.standard.integer(forKey: "id") ) + 1)
        p.pName = PNameTF.text ?? ""
        p.pPrice = Double(pPriceTF.text!) ?? 0.0
        
        if switchFav.isOn{
            p.pFavorite = 1
        }
        
        do {
            context.insert(p)
            try context.save()
            print("Insert Done")
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func Select(_ sender: UIButton) {
        
        let FR : NSFetchRequest<Product> = Product.fetchRequest()
        FR.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(FR)
            for result in results{
                
                print(result)
            }
        }catch{
            print(error)
        }
        
    }
    @IBAction func Update(_ sender: UIButton) {
        let FR : NSFetchRequest<Product> = Product.fetchRequest()
        let predicate = NSPredicate(format: "pName='\(PNameTF.text ?? "")'")
        FR.predicate = predicate
        
        do {
            let results = try context.fetch(FR)
            // to alter all product name
            //            for result in results{
            //
            //                result.pName = PNameTF.text ?? ""
            //            }
            // to alter product name you neede
            results.first?.pName = "Cat"
            try context.save()
            print("Data Updated")
        }catch{
            print(error)
        }
    }
    
    @IBAction func Delete(_ sender: UIButton) {
        let FR : NSFetchRequest<Product> = Product.fetchRequest()
        let predicate = NSPredicate(format: "pName='\(PNameTF.text ?? "")'")
        FR.predicate = predicate
        
        do {
            
            let results = try context.fetch(FR)
            guard let result = results.first else{return}
            context.delete(result)
            try context.save()
            print("Data Deleted")
        }catch{
            print(error)
        }
    }
    @IBAction func DeleteAll(_ sender: UIButton) {
        let FR : NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            
            let results = try context.fetch(FR)
            for result in results{
                context.delete(result)
            }
            try context.save()
            UserDefaults.standard.set(0, forKey: "id")
            print(" All Data Deleted")
        }catch{
            print(error)
        }
    }
    // MARK: Class Methods
    
    // MARK: Self Defined Methods
    
    
}
