//
//  ViewController.swift
//  Project22
//
//  Created by Novica Petrovic on 16/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager?
    var alertShown: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()

        view.backgroundColor = .gray
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("locationManager didChangeAuthorization called")
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }

    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")

        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)

        print("startScanning called")
    }

    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            print("update called")
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                print("case .far called")
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                print("case .near called")
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                print("case .immediate called")
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
                print("case default called")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("locationManager didRangeBeacons called")
        if let beacon = beacons.first {
            if alertShown == false {
                let alert =  UIAlertController(title: "\(beacon.uuid) Detected", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                alertShown = true
                present(alert, animated: true)
            }
            update(distance: beacon.proximity)
            print("if let beacon = beacon.first called")
        } else {
            update(distance: .unknown)
            print("else called")
        }
    }
}
