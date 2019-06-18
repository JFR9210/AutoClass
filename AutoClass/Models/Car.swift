//
//  car.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/8/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import Foundation

class Car : Decodable {
    
    var id: String!
    var patent: String!
    var brand_id: String!
    var model: String!
    var version: String!
    var km: String!
    var year: String!
    var color: String!
    var padron_vehiculo: String!
    var revision_tecnica: String!
    var revision_tecnica_vence: String!
    var permiso_circulacion: String!
    var permiso_circulacion_cuotas: String!
    var seguro_obligatorio: String!
    var seguro_danhos_propios: String!
    var cia_seguros: String!
    var tag: String!
    var prenda: String!
    var numero_duenhos: String!
    var manual_original: String!
    var libro_timbrado: String!
    var ultima_mantencion: String!
    var garantia: String!
    var vencimiento_garantia: String!
    var segunda_llave_original: String!
    var cilindrada: String!
    var potencia: String!
    var combustible: String!
    var tipo_transmision: String!
    var tipo_traccion: String!
    var vida_util_neumaticos: String!
    var tipo_llanta: String!
    var numero_airbags: String!
    var abs: String!
    var choque_estructural: String!
    var sensor_retroceso: String!
    var sensor_retroceso_camara: String!
    var aire_acondicionado: String!
    var climatizador_unico: String!
    var climatizador_unico_sectorizado: String!
    var anclaje_isofix: String!
    var tercera_corrida_asientos: String!
    var comentarios: String!
    var tipo_tapiz: String!
    var asiento_calefaccionado: String!
    var asientos_electricos: String!
    var sunroof: String!
    var control_crucero: String!
    var controles_al_volante: String!
    var alarma: String!
    var cierre_centralizado: String!
    var alzavidrios_delanteros: String!
    var bluetooth: String!
    var computador_a_bordo: String!
    var coco_arrastre: String!
    var barras_techo: String!
    var accesorios_extra: String!
    var foto1: String!
    var foto1Downloading: String!
    var foto1Datos: Data!
    var foto2: String!
    var foto2Downloading: String!
    var foto2Datos: Data!
    var foto3: String!
    var foto3Downloading: String!
    var foto3Datos: Data!
    var foto4: String!
    var foto4Downloading: String!
    var foto4Datos: Data!
    var created_date: String!
    var created_time: String!
    var state: String!
    var brand: Brand!
    
    init(id: String, patent: String, brand_id: String, model: String, version: String, km: String, year: String, color: String, padron_vehiculo: String, revision_tecnica: String, revision_tecnica_vence: String, permiso_circulacion: String, permiso_circulacion_cuotas: String, seguro_obligatorio: String, seguro_danhos_propios: String, cia_seguros: String, tag: String, prenda: String, numero_duenhos: String, manual_original: String, libro_timbrado: String, ultima_mantencion: String, garantia: String, vencimiento_garantia: String, segunda_llave_original: String, cilindrada: String, potencia: String, combustible: String, tipo_transmision: String, tipo_traccion: String, vida_util_neumaticos: String, tipo_llanta: String, numero_airbags: String, abs: String, choque_estructural: String, sensor_retroceso: String, sensor_retroceso_camara: String, aire_acondicionado: String, climatizador_unico: String, climatizador_unico_sectorizado: String, anclaje_isofix: String, tercera_corrida_asientos: String, comentarios: String, tipo_tapiz: String, asiento_calefaccionado: String, asientos_electricos: String, sunroof: String, control_crucero: String, controles_al_volante: String, alarma: String, cierre_centralizado: String, alzavidrios_delanteros: String, bluetooth: String, computador_a_bordo: String, coco_arrastre: String, barras_techo: String, accesorios_extra: String, foto1: String, foto2: String, foto3: String, foto4: String, created_date: String, created_time: String, state: String) {
        
        self.id = id
        self.patent = patent
        self.brand_id = brand_id
        self.model = model
        self.version = version
        self.km = km
        self.year = year
        self.color = color
        self.padron_vehiculo = padron_vehiculo
        self.revision_tecnica = revision_tecnica
        self.revision_tecnica_vence = revision_tecnica_vence
        self.permiso_circulacion = permiso_circulacion
        self.permiso_circulacion_cuotas = permiso_circulacion_cuotas
        self.seguro_obligatorio = seguro_obligatorio
        self.seguro_danhos_propios = seguro_danhos_propios
        self.cia_seguros = cia_seguros
        self.tag = tag
        self.prenda = prenda
        self.numero_duenhos = numero_duenhos
        self.manual_original = manual_original
        self.libro_timbrado = libro_timbrado
        self.ultima_mantencion = ultima_mantencion
        self.garantia = garantia
        self.vencimiento_garantia = vencimiento_garantia
        self.segunda_llave_original = segunda_llave_original
        self.cilindrada = cilindrada
        self.potencia = potencia
        self.combustible = combustible
        self.tipo_transmision = tipo_transmision
        self.tipo_traccion = tipo_traccion
        self.vida_util_neumaticos = vida_util_neumaticos
        self.tipo_llanta = tipo_llanta
        self.numero_airbags = numero_airbags
        self.abs = abs
        self.choque_estructural = choque_estructural
        self.sensor_retroceso = sensor_retroceso
        self.sensor_retroceso_camara = sensor_retroceso_camara
        self.aire_acondicionado = aire_acondicionado
        self.climatizador_unico = climatizador_unico
        self.climatizador_unico_sectorizado = climatizador_unico_sectorizado
        self.anclaje_isofix = anclaje_isofix
        self.tercera_corrida_asientos = tercera_corrida_asientos
        self.comentarios = comentarios
        self.tipo_tapiz = tipo_tapiz
        self.asiento_calefaccionado = asiento_calefaccionado
        self.asientos_electricos = asientos_electricos
        self.sunroof = sunroof
        self.control_crucero = control_crucero
        self.controles_al_volante = controles_al_volante
        self.alarma = alarma
        self.cierre_centralizado = cierre_centralizado
        self.alzavidrios_delanteros = alzavidrios_delanteros
        self.bluetooth = bluetooth
        self.computador_a_bordo = computador_a_bordo
        self.coco_arrastre = coco_arrastre
        self.barras_techo = barras_techo
        self.accesorios_extra = accesorios_extra
        self.foto1 = foto1
        self.foto2 = foto2
        self.foto3 = foto3
        self.foto4 = foto4
        self.created_date = created_date
        self.created_time = created_time
        self.state = state
        
    }
 
    func initWithJSON(jsonData : Data) -> Any{
        
        do {
            // Decode data to object
            let jsonDecoder = JSONDecoder()
            let car = try jsonDecoder.decode(Car.self, from: jsonData)
            return car
        }
        catch {
            
        }
        
        return false
        
    }
    
    func toDictionary(car: Car) -> [String: Any] {
        
        var json : [String : Any]!
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(car)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            
            do {
                
                json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                
                return json
                
            } catch {
                print("catch request")
            }
            
        }
        catch {
            
        }
        
        return json
    }
    
}

extension Car : Encodable {
    
    func setValueField(car : Car, field : String, answer : String) -> Car{
        
        var carNew = car
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(car)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            
            
            do {
                
                var json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                
                json[field] = answer
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    
                    do {
                        // Decode data to object
                        let jsonDecoder = JSONDecoder()
                        carNew = try jsonDecoder.decode(Car.self, from: jsonData)
                    } catch {
                        print("catch initWithJSON \(error)")
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            } catch {
                print("catch request")
            }
            
            
        }
        catch {
            
        }
        
        return carNew
    }
    
}
