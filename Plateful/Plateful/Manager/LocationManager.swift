//
//  LocationManager.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 20/05/2022.
//

import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject{
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    static let shared = LocationManager()
    @Published var userMapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.500972, longitude: -0.125313),span: .init(latitudeDelta: 0.001, longitudeDelta: 0.001))
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    func requestLocation(){
        manager.requestWhenInUseAuthorization() //get location
    }
    func stopUpdating(){
        manager.stopUpdatingLocation() //stop updating current user location
    }
    func startUpdating(){
        manager.startUpdatingLocation() //start updating current user location
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation = location //set location
        userMapRegion = MKCoordinateRegion(center: location.coordinate, span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)) //set region
    }
}

// MARK: - Get Placemark
extension LocationManager {
    
    func getPlace(for location: CLLocation,
                      completion: @escaping (CLPlacemark?) -> Void) {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                guard error == nil else { //return error if exists
                    completion(nil)
                    return
                }
                guard let placemark = placemarks?[0] else { //if a locality is found then assign
                    completion(nil)
                    return
                }
                
                completion(placemark) //return locality
            }
        }
}
