//
//  ClientsServiceTest.swift
//  gGymTests
//
//  Created by Jose Enrique Álvarez on 03/05/2019.
//  Copyright © 2019 Jose Enrique Álvarez. All rights reserved.
//
import XCTest
@testable import gGym

class ClientsServiceTest: XCTestCase {
    
    // UNIT TESTING
    func testGetClientsofInvalidCenter() {
        // Call backend service with not existing data
        let clients = ClientsService.getClientsCenter(idCenter: 1500000, idUser: 1)
        // Assert empty array received
        XCTAssertEqual(clients.count, 0)
    }
    
    func testGetClientsofValidCenter() {
        // Call backend service with not existing data
        let clients = ClientsService.getClientsCenter(idCenter: 1, idUser: 1)
        // Assert empty array received
        XCTAssertTrue(clients.count > 0, "There are not clients registered")
    }
    
    func testGetClientDetails() {
        // Call backend service for getting a client which exists
        let client = ClientsService.getClientInformation(idClient: 1, idUser: 1)
        // Assert not empty client received
        XCTAssertEqual(client.idAbonado, 1)
        XCTAssertFalse(client.nombre.isEmpty, "No se ha obtenido el nombre del cliente")
        XCTAssertFalse(client.apellidos.isEmpty, "No se ha obtenido el nombre del cliente")
    }
    
    func testCreateInvalidClient() {
        // Create an invalid client
        let client = Client(nombre: "", apellidos: "", direccion: "", ciudad: "", provincia: "", pais: "", codigoPostal: "", email: "", numeroTelefono: "", fechaNacimiento: Date.init())
        // Call backend service for creating the client
        let result = ClientsService.createClient(client: client!, idUser: 1)
        // Assert client was not created
        XCTAssertFalse(result, "Cliente creado")
    }
    
    func testUpdateClient() {
        // Get the details of a client
        let client = ClientsService.getClientInformation(idClient: 1, idUser: 1)
        // Update the zip code with a random number
        let randomZipCode = Int.random(in: 0 ... 10000)
        client.codigoPostal = String(randomZipCode)
        // Call backend service for updating the client
        let result = ClientsService.updateClient(client: client, idUser: 1)
        // Assert operation executed
        XCTAssertTrue(result, "Cliente no actualizado")
        // Recover user information again
        let updatedClient = ClientsService.getClientInformation(idClient: 1, idUser: 1)
        XCTAssertEqual(updatedClient.codigoPostal, String(randomZipCode))
    }
    
    // PERFORMANCE TESTING
    func testGetClientsofValidCenterPerformance() {
        self.measure {
            testGetClientsofValidCenter()
        }
    }
    
    func testGetClientDetailsPerformance() {
        self.measure {
            testGetClientDetails()
        }
    }
}
