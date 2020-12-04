import UIKit

class Project {
    var title: String
    var description: String
    var duration: Date?
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}


protocol ClientResponsibilities : class {
    func createProposal(for project: Project)
    func sendPayment()
}


class Client : ClientResponsibilities {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func createProposal(for project: Project) {
        //
    }
    
    func sendPayment() {
        //
    }
}

protocol ProductManagerResponsibilities : class {
    func setDeadLine(date: Date)
    func acceptSketch()
    func acceptFinalDesign()
    func createTrello(for members: [Developer])
}

class ProductManager : ProductManagerResponsibilities {
    var name: String
    var project: Project
    
    init(name: String, project: Project) {
        self.name = name
        self.project = project
    }
    
    func setDeadLine(date: Date) {
        //
    }
    
    func acceptSketch() {
        //
    }
    
    func acceptFinalDesign() {
        //
    }
    
    func createTrello(for members: [Developer]) {
        //
    }
}


protocol DeveloperManagerResponsibilities : class {
    func startDeveleopment()
}

class Developer : DeveloperManagerResponsibilities {
    
    
    var name: String
    var project: Project
    
    init(name: String, project: Project) {
        self.name = name
        self.project = project
    }
    
    func startDeveleopment() {
        //
    }
    
}


class OrderFacade {
    let client : Client
    let developers : [Developer]
    let productManager: ProductManager
    
    init(client : Client, developers : [Developer], productManager: ProductManager) {
        self.client = client
        self.productManager = productManager
        self.developers = developers
    }
    
    public func placeOrder(project: Project) {
        client.createProposal(for: project)
        client.sendPayment()
        productManager.acceptFinalDesign()
        productManager.acceptSketch()
        productManager.createTrello(for: developers)
        productManager.setDeadLine(date: Date())
        
        developers.forEach {
            $0.startDeveleopment()
        }
    }
}


let client = Client(name: "Babu")
let project = Project(title: "BALL App", description: "make Balls")
let productmanager = ProductManager(name: "Shambu", project: project)
let dev1 = Developer(name: "sree", project: project)
let dev2 = Developer(name: "rag", project: project)

let orderFacade = OrderFacade(client: client, developers: [dev1, dev2], productManager: productmanager)

orderFacade.placeOrder(project: project)

