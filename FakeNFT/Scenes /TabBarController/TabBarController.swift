import UIKit

final class TabBarController: UITabBarController {

    private let servicesAssembly: ServicesAssembly

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }
    
    private func setUpViewControllers() {
        let catalogViewController = CatalogViewController(
            servicesAssembly: servicesAssembly
        )
        let shoppingCartViewController = ShoppingCartViewController()
        let profileViewController = ProfileViewController(
            servicesAssembly: servicesAssembly
        )
        
        catalogViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Tab.catalog", comment: ""),
                                                        image: UIImage(named: "catalogNoActive"),
                                                        selectedImage: UIImage(named: "catalogActive"))
        shoppingCartViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Tab.cart", comment: ""),
                                                      image: UIImage(named: "basketNoActive"),
                                                      selectedImage: UIImage(named: "basketActive"))
        profileViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Tab.profile", comment: ""),
                                                      image: UIImage(named: "profileNoActive"),
                                                      selectedImage: UIImage(named: "profileActive"))
        
        viewControllers = [profileViewController, catalogViewController, shoppingCartViewController]
    }
}
