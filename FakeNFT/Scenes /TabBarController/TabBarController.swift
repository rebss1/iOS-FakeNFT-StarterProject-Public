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
        let shoppingCartViewController = ShoppingCartViewController(
            servicesAssembly: servicesAssembly
        )
        let networkClient = DefaultNetworkClient()
        let profileService = ProfileServiceImpl(
            networkClient: networkClient
        )
        let profilePresenter = ProfilePresenter(
            service: profileService,
            profileId: ProfileConstants.profileId
        )
        
        let profileController = ProfileViewController(presenter: profilePresenter)
        profilePresenter.profileView = profileController
        let profileNavigationController = UINavigationController(rootViewController: profileController)
        
        catalogViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Tab.catalog", comment: ""),
                                                        image: UIImage(named: "catalogNoActive"),
                                                        selectedImage: UIImage(named: "catalogActive"))
        shoppingCartViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Tab.cart", comment: ""),
                                                      image: UIImage(named: "basketNoActive"),
                                                      selectedImage: UIImage(named: "basketActive"))
        profileController.tabBarItem = UITabBarItem(title: NSLocalizedString("Tab.profile", comment: ""),
                                                      image: UIImage(named: "profileNoActive"),
                                                      selectedImage: UIImage(named: "profileActive"))
        
        viewControllers = [profileNavigationController, catalogViewController, shoppingCartViewController]
    }
    
}
