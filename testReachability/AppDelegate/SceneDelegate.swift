//
//  SceneDelegate.swift
//  testReachability
//
//  Created by Mohamed Ali on 24/12/2023.
//

import UIKit
import Combine

var reachability = CheckConnection()
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
//    var reachability = CheckConnection()
    private var cancellable = Set<AnyCancellable>()
    let navigation = UINavigationController(rootViewController: ViewController())

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
               
        window = UIWindow(windowScene: scene)
        noInternetConnection(navigationController: navigation)
        reachability.startNotify()
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
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

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

