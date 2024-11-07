final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let nftCollectionStorage: NftCollectionStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        nftCollectionStorage: NftCollectionStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.nftCollectionStorage = nftCollectionStorage
    }
    
    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var nftCollectionService: NftCollectionService {
        NftCollectionServiceImpl(
            networkClient: networkClient,
            storage: nftCollectionStorage
        )
    }
    
    var likedNftsService: LikedNftsService {
        LikedNftsServiceImpl(
            networkClient: networkClient
        )
    }
    
    var cartService: CartService {
        CartServiceImpl(
            networkClient: networkClient
        )
    }
    
    var profileService: ProfileService {
         ProfileServiceImpl(
             networkClient: networkClient
         )
     }
    
    var orderService: OrderService {
        OrderServiceImpl(
            networkClient: networkClient
        )
    }

    var currencyService: CurrencesGetService {
        CurrencesGetServiceImpl(
            networkClient: networkClient
        )
    }
    
    var payService: PayService {
        PayServiceImpl(
            networkClient: networkClient
        )
    }
}
