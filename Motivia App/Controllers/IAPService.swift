//
//  IAPService.swift
//  Sculpt
//
//  Created by Hamza Shahbaz on 09/02/2021.
//

import Foundation
import StoreKit

class IAPService: NSObject {
    
    private override init() {}
    static let shared = IAPService()
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    
    func getProduct() {
        
        let products: Set = [IAPProduct.autoRenowing.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
    }
    
    func purchase(product: IAPProduct) {
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        guard let productToPurchase = products.filter({$0.productIdentifier ==  product.rawValue}).first else {return}
        let payment = SKPayment(product: productToPurchase )
        SKPaymentQueue.default().add(self)
        paymentQueue.add(payment)
        
    }
}

extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        for product in response.products {
            print(product.localizedTitle)
        }
        self.products = response.products
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension IAPService: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        transactions.forEach({
            switch $0.transactionState {
            case .purchasing:
                break
            case .purchased:
                break
            case .failed:
                break
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        })
    }
}

extension SKPaymentTransactionState {
    
    func status() -> String {
        switch self {
        case .deferred: return "deferred"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .failed: return "failed"
        case .restored: return "restored"
        @unknown default:
            return ""
        }
    }
}
