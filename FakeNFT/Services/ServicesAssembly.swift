final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
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
