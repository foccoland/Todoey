//
//  TableViewController.swift
//  Todoey
//
//  Created by Fabio Giannelli on 28/04/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }


    
    // MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    // MARK: - Data Manipulation Methods
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error saving categories: \(error)")
        }
        tableView.reloadData()
    }
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving categories: \(error)")
        }
        tableView.reloadData()
    }
    
    // MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // show dialog
        var categoryTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { action in
            
            let category = Category(context: self.context)
            category.name = categoryTextField.text!
            
            self.categoryArray.append(category)
            
            self.saveCategories()
        }
        
        alert.addAction(action)
        
        alert.addTextField { textField in
            textField.placeholder = "Insert new category"
            categoryTextField = textField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - TableView Delegate Methods
    
}
