//
//  VehicleInfoViewController.swift
//  Vehicle Information
//
//  Created by Venkat on 12/09/24.
//

import UIKit
import AVFoundation

// MARK: - VehicleInfoViewController
/// ViewController for displaying and managing vehicle information.
class VehicleInfoViewController: UIViewController, ShowAlert {
    
    // MARK: - Outlets
    @IBOutlet weak var vehicleType: UIButton!
    @IBOutlet weak var vehicleCapacity: UIButton!
    @IBOutlet weak var vehicleMake: UIButton!
    @IBOutlet weak var manufactureYear: UIButton!
    @IBOutlet weak var fuelType: UIButton!
    @IBOutlet weak var imeiLbl: UILabel!
    
    // Radio button outlets
    @IBOutlet weak var radioButton1: UIButton!
    @IBOutlet weak var radioButton2: UIButton!
    
    // MARK: - Properties
    private let vehicleViewModel = VehicleViewModel()
    let session = AVCaptureSession()
    
    var vehicleList = [VehicleType]()
    var vehicleCapacityList = [VehicleCapacity]()
    var vehicleMakeList = [VehicleMake]()
    var manufactureYearList = [ManufactureYear]()
    var fuelTypeList = [FuelType]()
    
    var currentMenuType: MenuType = .type
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize title color
        radioButton1.tintColor = UIColor.red // Change to your desired tint color
        radioButton1.setTitleColor(UIColor.gray, for: .normal) // Change to your desired title color
        
        // Customize title color
        radioButton2.tintColor = UIColor.red // Change to your desired tint color
        radioButton2.setTitleColor(UIColor.gray, for: .normal) // Change to your desired title color
           
        
        // Adding tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        if isNetworkReachable() {
            
            // Fetch vehicle information
            vehicleViewModel.getVehicleInfo { result in
                switch result {
                case .success(let vehicleInfo):
                    
                    // Handle the successful response and use the vehicleInfo object
                    print("Vehicle Info:", vehicleInfo)
                    
                    self.vehicleList = vehicleInfo.vehicle_type!
                    self.vehicleCapacityList = vehicleInfo.vehicle_capacity!
                    self.vehicleMakeList = vehicleInfo.vehicle_make!
                    self.manufactureYearList = vehicleInfo.manufacture_year!
                    self.fuelTypeList = vehicleInfo.fuel_type!
                    
                case .failure(let error):
                    // Handle the error
                    print("Error fetching vehicle info:", error.localizedDescription)
                }
            }
        } else {
            self.showAlertWithActions(AKErrorHandler.CommonErrorMessages.NO_INTERNET_AVAILABLE)
        }
    }
    
    
    // Function to dismiss the keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - set up camera
    /// Sets up the camera for scanning QR codes.
    func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            let output = AVCaptureMetadataOutput()
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            session.addInput(input)
            session.addOutput(output)
            
            output.metadataObjectTypes = [.qr]
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            
            view.layer.addSublayer(previewLayer)
            session.startRunning()
            
        } catch {
            
            showAlert()
            print(error)
        }
    }
    
    // MARK: - Camera Access
    /// Requests access to the camera.
    func requestCameraAccess(completion: @escaping (Bool) -> Void) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
        case .notDetermined:
            // Request permission if not determined yet
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .restricted, .denied:
            // If permission is restricted or denied, inform the user
            completion(false)
        case .authorized:
            // Permission granted
            completion(true)
        @unknown default:
            // Handle future cases
            completion(false)
        }
    }
    
    // MARK: - Alert
    /// Shows an alert if scanning is not supported.
    func showAlert() {
        let alert = UIAlertController(title: Scanner.alertTitle,
                                      message: Scanner.alertMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Scanner.alertButtonTitle,
                                      style: .default))
        present(alert, animated: true)
    }
    
    
    // MARK: - Actions
    @IBAction func scannerButtonTapped(_ sender: UIButton) {
        
        setupCamera()
        
        requestCameraAccess { granted in
            if granted {
                // Start the QR code scanner
                // startQRCodeScanner()
            } else {
                // Handle the case where permission is denied
                print("Camera access denied")
                
                let alert = UIAlertController(title: "Camera Access Needed",
                                              message: "Please enable camera access in Settings to scan QR codes.",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl)
                    }
                })
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
    }
    
    
    @IBAction func vehicleMenuTapped(_ sender: UIButton) {
        guard let menuType = MenuType(rawValue: sender.tag) else { return }
        
        // Dynamically choose the menu based on `currentMenuType`
        switch menuType.rawValue {
            
        case 1:
            let menu = createMenu(from: vehicleList, type: .type, title: "Vehicles")
            sender.menu = menu
            
        case 2:
            let menu = createMenu(from: vehicleMakeList, type: .make, title: "Makers")
            sender.menu = menu
            
        case 3:
            let menu = createMenu(from: manufactureYearList, type: .manufactureYear, title: "Manufacture Year")
            sender.menu = menu
            
        case 4:
            let menu = createMenu(from: fuelTypeList, type: .fuelType, title: "Fuel Type")
            sender.menu = menu
            
        case 5:
            let menu = createMenu(from: vehicleCapacityList, type: .capacity, title: "Capacity")
            sender.menu = menu
            
        default:
            print("test")
        }
        
        sender.showsMenuAsPrimaryAction = true
    }
    
    // MARK: - Menu Creation
    /// Creates a UIMenu from a list of items.
    func createMenu(from items: [Any], type: MenuType, title: String) -> UIMenu {
        let actions = items.map { item -> UIAction in
            // Handle different types of items in the array
            
            if let modelItem = item as? VehicleType {
                return UIAction(title: modelItem.text!) { _ in
                    self.handleMenuAction(item: modelItem.text!, menuType: type)
                }
            } else if let modelItem = item as? VehicleCapacity {
                return UIAction(title: modelItem.text!) { _ in
                    self.handleMenuAction(item: modelItem.text!, menuType: type)
                }
            } else if let modelItem = item as? VehicleMake {
                return UIAction(title: modelItem.text!) { _ in
                    self.handleMenuAction(item: modelItem.text!, menuType: type)
                }
            } else if let modelItem = item as? ManufactureYear {
                return UIAction(title: modelItem.text!) { _ in
                    self.handleMenuAction(item: modelItem.text!, menuType: type)
                }
            } else if let modelItem = item as? FuelType {
                return UIAction(title: modelItem.text!) { _ in
                    self.handleMenuAction(item: modelItem.text!, menuType: type)
                }
            } else {
                return UIAction(title: "Unknown Item") { _ in
                    print("Unknown item type")
                }
            }
        }
        return UIMenu(title: title, children: actions)
    }
    
    
    // MARK: - Menu Handling
    /// Handles the selection of a menu item.
    func handleMenuAction(item: String, menuType: MenuType) {
        switch menuType {
        case .type:
            self.vehicleType.setTitle("\(item)", for: .normal)
        case .capacity:
            self.vehicleCapacity.setTitle("\(item)", for: .normal)
        case .make:
            self.vehicleMake.setTitle("\(item)", for: .normal)
        case .manufactureYear:
            self.manufactureYear.setTitle("\(item)", for: .normal)
        case .fuelType:
            self.fuelType.setTitle("\(item)", for: .normal)
        }
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension VehicleInfoViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              metadataObject.type == .qr,
              let stringValue = metadataObject.stringValue else { return }
        self.imeiLbl.text = stringValue
    }
}
