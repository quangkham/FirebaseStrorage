//
//  ViewController.swift
//  CoffeeStore
//
//  Created by Quang Kham on 19/05/2020.
//  Copyright © 2020 Quang Kham. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController  ,UITableViewDelegate, UITableViewDataSource{
    
    let storage = Storage.storage()
    var urlFromReference : URL!
    var coffeeLists =  [Coffee]()
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var coffeeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateURL()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        
    }
    
    func generateURL(){
        
        let gsReference = storage.reference(forURL: "gs://coffeestore-ecdc3.appspot.com/coffee.json")
        gsReference.downloadURL { (url, error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                
                self.urlFromReference = url
                guard  self.urlFromReference != nil else{
                    return
                }
                let session = URLSession.shared
                let dataTask = session.dataTask(with: self.urlFromReference!) { (data, response, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    if let data = data{
                        self.coffeeLists = self.parseDataFromJson(data: data)
                        OperationQueue.main.addOperation({
                            self.tabelView.reloadData()
                        })
                    }
                }
                dataTask.resume()//***make the API call
            }
            
            
        }
    }
    
    func parseDataFromJson(data : Data) -> [Coffee]{
            var coffees = [Coffee]()
            do {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary{
                    let coffeeDatas = jsonObj["coffees"] as! [AnyObject]
                    for jsoncoffee in coffeeDatas {
                        let coffee = Coffee()
                        coffee.name = jsoncoffee["name"] as! String
                        coffee.description = jsoncoffee["description"] as! String
                        coffee.image = jsoncoffee["image"] as! String
                        coffee.price = jsoncoffee["prices"] as! [String :Any]
                        coffees.append(coffee)
                    }
                }

            }
            catch {
                print(error.localizedDescription)
            }
        return coffees
        }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return coffeeLists.count
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoffeeTableViewCell
     
        // Configure the cell...
        cell.name.text = coffeeLists[indexPath.row].name
        //cell.photo.image = UIImage(named: coffeeLists[indexPath.row].image!)
        print(coffeeLists[indexPath.row].image!)
        return cell
    }
}
    
  /*  1.let json = try JSONSerialization.data(withJSONObject: jsonData,   options: .prettyPrinte
    2.let reqJSONStr = String(data: json as! Data, encoding: .utf8)
    3.let data = reqJSONStr?.data(using: .utf8)) change json to data
   */
    /*
     if error == nil && data != nil{
         //parse Json
         let decoder = JSONDecoder()
         do {
             
             let coffeeData = try decoder.decode(coffeeStore.self, from: data!)
                 print(coffeeData)
         }
         catch{
             print(error.localizedDescription)
         }
     }

     */


