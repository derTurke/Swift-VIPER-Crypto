//
//  Interactor.swift
//  Swift-VIPER-Crypto
//
//  Created by GÜRHAN YUVARLAK on 24.08.2022.
//

import Foundation
import Alamofire
// Class, Protocol
// Talks to -> presenter

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json") else { return }
        AF.request(url).responseDecodable(of: [Crypto].self) { response in
            switch response.result {
                case .success(let cryptos):
                    self.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
                case .failure(_):
                    self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
    }
}
