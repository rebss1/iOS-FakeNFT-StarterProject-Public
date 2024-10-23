import UIKit
import ProgressHUD

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        configProgressHUD()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    private func configProgressHUD() {
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.colorHUD = .whiteUniversal
        ProgressHUD.colorAnimation = .blackUniversal
    }
}
