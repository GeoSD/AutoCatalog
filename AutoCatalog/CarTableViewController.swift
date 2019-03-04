//
//  CarTableViewController.swift
//  AutoCatalog
//
//  Created by Georgy Dyagilev on 02/03/2019.
//  Copyright © 2019 Georgy Dyagilev. All rights reserved.
//

import UIKit

class CarTableViewController: UITableViewController {
    
    let carManager = CarManager.shared
    var cars: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadCars),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell",
                                                 for: indexPath) as! CarTableViewCell
        
        let car = cars[indexPath.row]
        cell.manufacturerLabel.text = car.manufacturer
        cell.modelLabel.text = car.model
        cell.carTypeLabel.text = car.carType.rawValue
        cell.carClassLabel.text = car.carClass.rawValue
        cell.yearLabel.text = "\(car.year)"
        
        return cell
    }
    
    @objc func loadCars() {
        cars = carManager.loadCarsFromUserDefaults()
        tableView.reloadData()
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            carManager.saveCarsToUserDefaults(cars)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditSegue" {
            let addEditTVC = segue.destination as! AddEditTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let car = cars[selectedIndexPath.row]
            addEditTVC.car = car
            addEditTVC.addFlag = false
        }
    }
    
    @IBAction func unwindFromAddEditTVC(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "SaveUnwind" {
            let addEditTVC = unwindSegue.source as! AddEditTableViewController
            
            if addEditTVC.addFlag {
                let newManufacturer = addEditTVC.manufacturerTextField.text
                let newModel = addEditTVC.modelTextField.text
                let newCarType = CarType(rawValue: addEditTVC.carTypeTextField.text!)
                let newCarClass = CarClass(rawValue: addEditTVC.carClassTextField.text!)
                let newYear = Int(addEditTVC.yearTextField.text ?? "1900")
                
                let newCar = Car(year: newYear!,
                                 model: newModel!,
                                 manufacturer: newManufacturer!,
                                 carClass: newCarClass!,
                                 carType: newCarType!)
                cars.append(newCar)
                tableView.insertRows(at: [IndexPath(row: cars.count - 1, section: 0)], with: .automatic)
            } else {
                let selectedRow = tableView.indexPathForSelectedRow!
                guard let car = addEditTVC.car else { return }
                cars[(selectedRow.row)] = car
                tableView.reloadRows(at: [selectedRow], with: .automatic)
            }
            tableView.reloadData()
            carManager.saveCarsToUserDefaults(cars)
        }
    }
}
