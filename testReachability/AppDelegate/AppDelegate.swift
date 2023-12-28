//
//  AppDelegate.swift
//  testReachability
//
//  Created by Mohamed Ali on 24/12/2023.
//

import UIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    let navigation = UINavigationController(rootViewController: ViewController())
    private var cancellable = Set<AnyCancellable>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        noInternetConnection(navigationController: navigation)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        noInternetConnection(navigationController: navigation)
        return true
    }
    
    func noInternetConnection(navigationController: UINavigationController) {
        
        reachability.connectionStatusObservable.sink(receiveValue: { status in
            let vc = NoInternetConnection()
            vc.modalPresentationStyle = .fullScreen
            
            print(status)
            
            switch status {
                case .unspecified: break
                case .connected:
                    navigationController.topViewController?.dismiss(animated: true)
                case .WifiNotValid:
                    navigationController.topViewController?.present(vc, animated: true)
                case .disconnected:
                    navigationController.topViewController?.present(vc, animated: true)
                case .error: break
            }
            
        }).store(in: &cancellable)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

