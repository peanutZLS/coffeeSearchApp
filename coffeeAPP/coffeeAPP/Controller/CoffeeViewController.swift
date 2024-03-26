//
//  CoffeeViewController.swift
//  coffeeAPP
//
//  Created by 郭家宇 on 2024/3/26.
//

import UIKit

class CoffeeViewController: UIViewController {

    var cafes=[CaseInfo]()
    
    var pickerView=UIPickerView()//實例建立Pickerview
    
    let cities=["taipei","yilan","taoyuan","hsinchu","miaoli","taichung","changhua","Nantou","Yunlin","Chiayi","Tainan","Kaohsiung","Pingtung"]
    
    
    let apiUrlString="https://cafenomad.tw/api/v1.2/cafes" //原來API網址
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
       tableView.delegate = self
        tableView.dataSource = self
        textField.inputView = pickerView
        textField.textAlignment = .center
        textField.placeholder = "Select a City"
                
    }
    
    @IBAction func searchCity(_ sender: Any) {
        if let searchText = textField.text{
            let urlString = "\(apiUrlString)/\(searchText)"
            if let url = URL(string: urlString){
                URLSession.shared.dataTask(with: url){
                    (data,response,error) in
                    let decoder = JSONDecoder()
                    if let data = data ,let coffeeResult = try?decoder.decode([CaseInfo].self, from: data){
                        self.cafes = coffeeResult
                        //print(coffeeResult)
                        //print(self.cafes.count)
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                    }
                }.resume()
            }
        }
    }
    

}
extension CoffeeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTableViewCell", for: indexPath) as! CoffeeTableViewCell
        let coffeeInfo = cafes[indexPath.row]
        cell.coffeeName.text = coffeeInfo.name
        print(coffeeInfo.name)
        cell.coffeeAddress.text = coffeeInfo.address
        print(coffeeInfo.address)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let vc = segue.destination as! DetailDataViewController
                vc.cafeData = cafes[indexPath.row]
            }
        }
    }
    
    
}


extension CoffeeViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //將pickerView選的資料放入textfield中
        textField.text=cities[row]
        //結束選擇
        textField.resignFirstResponder()
        
    }
}
