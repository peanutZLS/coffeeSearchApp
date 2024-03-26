//
//  DetailDataViewController.swift
//  coffeeAPP
//
//  Created by 郭家宇 on 2024/3/26.
//

import UIKit
import MapKit
class DetailDataViewController: UIViewController {

    @IBOutlet weak var coffeeName: UILabel!
    @IBOutlet weak var coffeeAddress: UILabel!
    @IBOutlet weak var openTime: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonn: UIButton!
    var latitude=0.0
    
    var longitude=0.0
    
    var cafeData:CaseInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        if let cafeData = cafeData{
            latitude = Double(cafeData.latitude)!
            longitude = Double(cafeData.longitude)!
            
            coffeeName.text = cafeData.name
            coffeeAddress.text = cafeData.address
            if cafeData.open_time.isEmpty {
                // 如果 open_time 是空字符串，則表示沒有提供開放時間
                openTime.text = "開放時間未提供"
            } else {
                // 否則，假設提供了開放時間，使用它
                openTime.text = ("\(cafeData.open_time)")
            }

        }
        
        settingcafeAnnotation()
        print(latitude)
        print(longitude)
        
    }
    
    @IBAction func navy(_ sender: Any) {
        map()
    }
    
    func settingcafeAnnotation(){
        let studioAnnotation = MKPointAnnotation()
        studioAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // 設置大頭針標題
        studioAnnotation.title = cafeData?.name
        // 設置大頭針副標題，點選後可以看見
        studioAnnotation.subtitle = cafeData?.address
        mapView.setCenter(studioAnnotation.coordinate, animated: true)
        // 更改當前可見區域，並且根據指定的坐標和距離值創建新的MKCoordinateRegion
        mapView.setRegion(MKCoordinateRegion(center: studioAnnotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200), animated: true)
        mapView.addAnnotation(studioAnnotation)
    }
    func map(){
        if let cafeData=cafeData{
                   
                   latitude=Double(cafeData.latitude)!
                   longitude=Double(cafeData.longitude)!
                   
                   coffeeName.text=cafeData.name
                   coffeeAddress.text=cafeData.address
                   openTime.text="\(cafeData.open_time)"
                   
               }
        let targetLocation=CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //初始化使用MKPlacemark
        let targetPlacemark=MKPlacemark(coordinate: targetLocation)
        
        let targetItem=MKMapItem(placemark: targetPlacemark)
        
        let userMapItem=MKMapItem.forCurrentLocation()
        
        print(userMapItem)
        let routes=[userMapItem,targetItem]
        MKMapItem.openMaps(with: routes, launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
