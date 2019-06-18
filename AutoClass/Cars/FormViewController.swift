//
//  FormViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 5/21/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {

    var indexPhoto = 0
    @IBOutlet weak var collection: UICollectionView!
    var listPhotos : [Data] = []
    
    let notificationOpenKeyboard = NotificationCenter.default
    let notificationCloseKeyboard = NotificationCenter.default
    weak var fieldActive: UITextField!
    var tabGesture = UITapGestureRecognizer()
    
    var car : Car!
    var listForm : [Form] = []
    var listForm2 : [Form] = []
    var listSectionsForm : [FormSection] = []
    
    @IBOutlet weak var btnSave: UIButton!
    @IBAction func save(_ sender: Any) {
        
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        
        var dictionary : [String : Any] = car.toDictionary(car: car)
        dictionary.updateValue(listPhotos[0], forKey: "foto1Datos")
        dictionary.updateValue(listPhotos[1], forKey: "foto2Datos")
        dictionary.updateValue(listPhotos[2], forKey: "foto3Datos")
        dictionary.updateValue(listPhotos[3], forKey: "foto4Datos")
        
        CarService.editCarImage(VC: self, jsonParams: dictionary) { (Car) in
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.delegate.updateCar(car: Car)
            self.car = Car
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    var delegate : CarDelegate!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indicator.isHidden = true
        
        let photo1 : Data = UIImage(named: "placeholder_car_1")!.pngData()!
        self.listPhotos.append(photo1)
        let photo2 : Data = UIImage(named: "placeholder_car_2")!.pngData()!
        self.listPhotos.append(photo2)
        let photo3 : Data = UIImage(named: "placeholder_car_3")!.pngData()!
        self.listPhotos.append(photo3)
        let photo4 : Data = UIImage(named: "placeholder_car_4")!.pngData()!
        self.listPhotos.append(photo4)
        
        self.table.delegate = self
        self.table.dataSource = self
        self.collection.delegate = self
        self.collection.dataSource = self
        
        self.loadData()
        
    }
    
    func loadData(){
        
        self.listSectionsForm = []
        self.listForm = []
        self.listForm2 = []
        
        let padron_vehiculo : Form = Form(question: "Padrón Vehículo:", answer: car.padron_vehiculo, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "padron_vehiculo")
        self.listForm.append(padron_vehiculo)
        
        let revision_tecnica : Form = Form(question: "Revisión Técnica:", answer: car.revision_tecnica, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "revision_tecnica")
        self.listForm.append(revision_tecnica)
        
        let revision_tecnica_vence : Form = Form(question: "Vence:", answer: car.revision_tecnica_vence, type: "TEXT", typeKeyboard: "DATE_2", titleQuestion1: "MM/AAAA", titleQuestion2: "", section: "0", field: "revision_tecnica_vence")
        self.listForm.append(revision_tecnica_vence)
        
        let permiso_circulacion : Form = Form(question: "Permiso de Circulación:", answer: car.permiso_circulacion, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "permiso_circulacion")
        self.listForm.append(permiso_circulacion)
        
        let permiso_circulacion_cuotas : Form = Form(question: "Cuotas:", answer: car.permiso_circulacion_cuotas, type: "TEXT", typeKeyboard: "NUMBER", titleQuestion1: "Ej: 1 o 2", titleQuestion2: "", section: "0", field: "permiso_circulacion_cuotas")
        self.listForm.append(permiso_circulacion_cuotas)
        
        let seguro_obligatorio : Form = Form(question: "Seguro Obligatorio:", answer: car.seguro_obligatorio, type: "BUTTON", typeKeyboard: "BUTTOn", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "seguro_obligatorio")
        self.listForm.append(seguro_obligatorio)
        
        let seguro_danhos_propios : Form = Form(question: "Seguro Daños Propios:", answer: car.seguro_danhos_propios, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "seguro_danhos_propios")
        self.listForm.append(seguro_danhos_propios)
        
        let cia_seguros : Form = Form(question: "Cía. Seguros:", answer: car.cia_seguros, type: "TEXT", typeKeyboard: "DEFAULT", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "cia_seguros")
        self.listForm.append(cia_seguros)
        
        let tag : Form = Form(question: "TAG:", answer: car.tag, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "tag")
        self.listForm.append(tag)
        
        let prenda : Form = Form(question: "Prenda:", answer: car.prenda, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "prenda")
        self.listForm.append(prenda)
        
        let numero_duenhos : Form = Form(question: "Nro. Dueños:", answer: car.numero_duenhos, type: "TEXT", typeKeyboard: "NUMBER", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "numero_duenhos")
        self.listForm.append(numero_duenhos)
        
        let manual_original : Form = Form(question: "Manual Original:", answer: car.manual_original, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "manual_original")
        self.listForm.append(manual_original)
        
        let libro_timbrado : Form = Form(question: "Libro Timbrado:", answer: car.libro_timbrado, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "libro_timbrado")
        self.listForm.append(libro_timbrado)
        
        let ultima_mantencion : Form = Form(question: "Última Mantención:", answer: car.ultima_mantencion, type: "TEXT", typeKeyboard: "NUMBER", titleQuestion1: "Ej: 30.000 Km", titleQuestion2: "", section: "0", field: "ultima_mantencion")
        self.listForm.append(ultima_mantencion)
        
        let garantia : Form = Form(question: "Garantía:", answer: car.garantia, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "garantia")
        self.listForm.append(garantia)
        
        let vencimiento_garantia : Form = Form(question: "Vencimiento Garantía:", answer: car.vencimiento_garantia, type: "TEXT", typeKeyboard: "DATE_2", titleQuestion1: "MM/AAAA", titleQuestion2: "", section: "0", field: "vencimiento_garantia")
        self.listForm.append(vencimiento_garantia)
        
        let segunda_llave_original : Form = Form(question: "Segunda llave Original:", answer: car.segunda_llave_original, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "segunda_llave_original")
        self.listForm.append(segunda_llave_original)
        
        let formSection1 : FormSection = FormSection(title: "DOCUMENTACIÓN VEHÍCULO", items: listForm)
        self.listSectionsForm.append(formSection1)
        
        
        let cilindrada : Form = Form(question: "Cilindrada (cc):", answer: car.cilindrada, type: "TEXT", typeKeyboard: "NUMBER", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "cilindrada")
        self.listForm2.append(cilindrada)
        
        let potencia : Form = Form(question: "Potencia (HP):", answer: car.potencia, type: "TEXT", typeKeyboard: "NUMBER", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "potencia")
        self.listForm2.append(potencia)
        
        let combustible : Form = Form(question: "Combustible:", answer: car.combustible, type: "TEXT", typeKeyboard: "DEFAULT", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "combustible")
        self.listForm2.append(combustible)
        
        let tipo_transmision : Form = Form(question: "Tipo de Transmisión:", answer: car.tipo_transmision, type: "TEXT", typeKeyboard: "DEFAULT", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "tipo_transmision")
        self.listForm2.append(tipo_transmision)
        
        let tipo_traccion : Form = Form(question: "Tipo de Tracción:", answer: car.tipo_traccion, type: "TEXT", typeKeyboard: "DEFAULT", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "tipo_traccion")
        self.listForm2.append(tipo_traccion)
        
        let vida_util_neumaticos : Form = Form(question: "Vida Útil Neumáticos (%):", answer: car.vida_util_neumaticos, type: "TEXT", typeKeyboard: "DECIMAL", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "vida_util_neumaticos")
        self.listForm2.append(vida_util_neumaticos)
        
        let tipo_llanta : Form = Form(question: "Tipo de Llanta:", answer: car.tipo_llanta, type: "TEXT", typeKeyboard: "DEFAULT", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "tipo_llanta")
        self.listForm2.append(tipo_llanta)
        
        let numero_airbags : Form = Form(question: "Nro Airbags:", answer: car.numero_airbags, type: "TEXT", typeKeyboard: "NUMBER", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "numero_airbags")
        self.listForm2.append(numero_airbags)
        
        let abs : Form = Form(question: "ABS:", answer: car.abs, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "abs")
        self.listForm2.append(abs)
        
        let choque_estructural : Form = Form(question: "Choque Estructural:", answer: car.choque_estructural, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "choque_estructural")
        self.listForm2.append(choque_estructural)
        
        let sensor_retroceso : Form = Form(question: "Sensor Retroceso:", answer: car.sensor_retroceso, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "sensor_retroceso")
        self.listForm2.append(sensor_retroceso)
        
        let sensor_retroceso_camara : Form = Form(question: "Con cámara:", answer: car.sensor_retroceso_camara, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "sensor_retroceso_camara")
        self.listForm2.append(sensor_retroceso_camara)
        
        let aire_acondicionado : Form = Form(question: "Aire Acondicionado:", answer: car.aire_acondicionado, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "aire_acondicionado")
        self.listForm2.append(aire_acondicionado)
        
        let climatizador_unico : Form = Form(question: "Climatizador Único:", answer: car.climatizador_unico, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "climatizador_unico")
        self.listForm2.append(climatizador_unico)
        
        let climatizador_unico_sectorizado : Form = Form(question: "Sectorizado:", answer: car.climatizador_unico_sectorizado, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "climatizador_unico_sectorizado")
        self.listForm2.append(climatizador_unico_sectorizado)
        
        let anclaje_isofix : Form = Form(question: "Anclaje Isofix:", answer: car.anclaje_isofix, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "anclaje_isofix")
        self.listForm2.append(anclaje_isofix)
        
        let tercera_corrida_asientos : Form = Form(question: "3o Corrida de Asientos:", answer: car.tercera_corrida_asientos, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "tercera_corrida_asientos")
        self.listForm2.append(tercera_corrida_asientos)
        
        let tipo_tapiz : Form = Form(question: "Tipo Tapiz:", answer: car.tipo_tapiz, type: "TEXT", typeKeyboard: "DEFAULT", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "tipo_tapiz")
        self.listForm2.append(tipo_tapiz)
        
        let asiento_calefaccionado : Form = Form(question: "Asiento Calefaccionado:", answer: car.asiento_calefaccionado, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "asiento_calefaccionado")
        self.listForm2.append(asiento_calefaccionado)
        
        let asientos_electricos : Form = Form(question: "Asientos Eléctricos:", answer: car.asientos_electricos, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "asientos_electricos")
        self.listForm2.append(asientos_electricos)
        
        let sunroof : Form = Form(question: "Sunroof:", answer: car.sunroof, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "sunroof")
        self.listForm2.append(sunroof)
        
        let control_crucero : Form = Form(question: "Control Crucero:", answer: car.control_crucero, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "control_crucero")
        self.listForm2.append(control_crucero)
        
        let controles_al_volante : Form = Form(question: "Controles al Volante:", answer: car.controles_al_volante, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "controles_al_volante")
        self.listForm2.append(controles_al_volante)
        
        let alarma : Form = Form(question: "Alarma:", answer: car.alarma, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "alarma")
        self.listForm2.append(alarma)
        
        let cierre_centralizado : Form = Form(question: "Cierre Centralizado:", answer: car.cierre_centralizado, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "cierre_centralizado")
        self.listForm2.append(cierre_centralizado)
        
        let alzavidrios_delanteros : Form = Form(question: "Alzavidrios Delanteros:", answer: car.alzavidrios_delanteros, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "alzavidrios_delanteros")
        self.listForm2.append(alzavidrios_delanteros)
        
        let bluetooth : Form = Form(question: "Bluetooth:", answer: car.bluetooth, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "bluetooth")
        self.listForm2.append(bluetooth)
        
        let computador_a_bordo : Form = Form(question: "Computador a Bordo:", answer: car.computador_a_bordo, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "computador_a_bordo")
        self.listForm2.append(computador_a_bordo)
        
        let coco_arrastre : Form = Form(question: "Coco de Arrastre:", answer: car.coco_arrastre, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "coco_arrastre")
        self.listForm2.append(coco_arrastre)
        
        let barras_techo : Form = Form(question: "Barras de Techo:", answer: car.barras_techo, type: "BUTTON", typeKeyboard: "DEFAULT", titleQuestion1: "SI", titleQuestion2: "NO", section: "0", field: "barras_techo")
        self.listForm2.append(barras_techo)
        
        let accesorios_extra : Form = Form(question: "Accesorios Extra:", answer: car.accesorios_extra, type: "TEXT", typeKeyboard: "DEFAULT", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "accesorios_extra")
        self.listForm2.append(accesorios_extra)
        
        let comentarios : Form = Form(question: "Comentarios:", answer: car.comentarios, type: "TEXT", typeKeyboard: "DEFAULT", titleQuestion1: "Escribe aquí", titleQuestion2: "", section: "0", field: "comentarios")
        self.listForm2.append(comentarios)
        
        let formSection2 : FormSection = FormSection(title: "DESCRIPCIÓN VEHÍCULO", items: listForm2)
        self.listSectionsForm.append(formSection2)
        
        self.table.reloadData()
        
        if car.foto1 != nil && car.foto1.count > 0 {
            self.downloadPhoto1(car: car)
        }
        
        if car.foto2 != nil && car.foto2.count > 0 {
            self.downloadPhoto2(car: car)
        }
        
        if car.foto3 != nil && car.foto3.count > 0 {
            self.downloadPhoto3(car: car)
        }
        
        if car.foto4 != nil && car.foto4.count > 0 {
            self.downloadPhoto4(car: car)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "FORMULARIO AUTO"
        
        tabGesture.addTarget(self, action: #selector(hideKeyboard(sender:)))
        //self.view.addGestureRecognizer(tabGesture)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //No escuchar mas la notificacion de teclado en esta vista
        notificationOpenKeyboard.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        notificationCloseKeyboard.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notificationOpenKeyboard.addObserver(self, selector: #selector(openKeyboard(notificacion:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        notificationCloseKeyboard.addObserver(self, selector: #selector(closeKeyboard(notificacion:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fieldActive = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fieldActive = textField
    }
    
    @objc
    func openKeyboard(notificacion: Notification){
        print("Open keyboard")
        if let keyboardFrame: NSValue = notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            table.contentInset = edgeInsets
            table.scrollIndicatorInsets = edgeInsets
//            table.scrollRectToVisible(fieldActive.frame, animated: true)
            
        }
    }
    
    @objc
    func closeKeyboard(notificacion: Notification){
        print("Close keyboard")
        let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.contentInset = edgeInsets
        table.scrollIndicatorInsets = edgeInsets
        //scrollView.scrollRectToVisible(fieldActive.frame, animated: true)
    }
    
    @objc func hideKeyboard(sender:UIPanGestureRecognizer){
        print("Hide keyboard")
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let buttonPosition = textField.convert(CGPoint.zero, to: self.table)
        let indexPath = self.table.indexPathForRow(at: buttonPosition)
        if indexPath != nil {
            
            let form : Form = listSectionsForm[indexPath!.section].items[indexPath!.row]
            if (textField.text!.count >= 10 && range.length == 0 && form.typeKeyboard == "DATE") {
                return false
            } else if (textField.text!.count >= 7 && range.length == 0 && form.typeKeyboard == "DATE_2") {
                return false
            } else {
                return true
            }
            
        } else {
            return true
        }
        
    }
    
    var validateTextEditing = 0
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        let touchPoint : CGPoint = textField.convert(CGPoint.zero, to: table)
        let indexPath : NSIndexPath = table.indexPathForRow(at: touchPoint)! as NSIndexPath
        
        let form : Form = listSectionsForm[indexPath.section].items[indexPath.row]
        form.answer = textField.text
        
        table.reloadData()
        fieldActive = nil
        
        self.updateCar(form: form)
        
        print("textFieldDidEndEditing \(form.question!) \(form.answer!)")
        
    }
    
    func updateCar(form: Form){
        car = car.setValueField(car: car, field: form.field, answer: form.answer)
    }
    
    func downloadPhoto1(car: Car) {
        if car.foto1Downloading == nil {
            car.foto1Downloading = "1"
            print("URL Foto 1 \(Utils.URL_SERVER_IMG)\(car.foto1!)")
            let url = URL(string:"\(Utils.URL_SERVER_IMG)\(car.foto1!)")
            let request = URLRequest(url: url!)
            let task = URLSession.shared.dataTask(with: request){data,response,error in
                if error == nil {
                    DispatchQueue.main.async(execute: {
                        print("Descargo Foto 1")
//                        car.foto1Datos = data
                        self.listPhotos[0] = data!
                        self.collection.reloadData()
                    })
                    
                } else {
                    print(error!.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func downloadPhoto2(car: Car) {
        if car.foto2Downloading == nil {
            car.foto2Downloading = "1"
            let url = URL(string:"\(Utils.URL_SERVER_IMG)\(car.foto2!)")
            let request = URLRequest(url: url!)
            let task = URLSession.shared.dataTask(with: request){data,response,error in
                if error == nil {
                    DispatchQueue.main.async(execute: {
//                        car.foto2Datos = data
                        self.listPhotos[1] = data!
                        self.collection.reloadData()
                    })
                    
                } else {
                    print(error!.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func downloadPhoto3(car: Car) {
        if car.foto3Downloading == nil {
            car.foto3Downloading = "1"
            let url = URL(string:"\(Utils.URL_SERVER_IMG)\(car.foto3!)")
            let request = URLRequest(url: url!)
            let task = URLSession.shared.dataTask(with: request){data,response,error in
                if error == nil {
                    DispatchQueue.main.async(execute: {
//                        car.foto3Datos = data
                        self.listPhotos[2] = data!
                        self.collection.reloadData()
                    })
                    
                } else {
                    print(error!.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func downloadPhoto4(car: Car) {
        if car.foto4Downloading == nil {
            car.foto4Downloading = "1"
            let url = URL(string:"\(Utils.URL_SERVER_IMG)\(car.foto4!)")
            let request = URLRequest(url: url!)
            let task = URLSession.shared.dataTask(with: request){data,response,error in
                if error == nil {
                    DispatchQueue.main.async(execute: {
//                        car.foto4Datos = data
                        self.listPhotos[3] = data!
                        self.collection.reloadData()
                    })
                    
                } else {
                    print(error!.localizedDescription)
                }
            }
            task.resume()
        }
    }

}

extension FormViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let form : Form = listSectionsForm[indexPath.section].items[indexPath.row]
        if form.type == "BUTTON" {
            return 130
        } else {
            return 140
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listSectionsForm.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listSectionsForm[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSectionsForm[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        let form : Form = listSectionsForm[indexPath.section].items[indexPath.row]
        
        if form.type == "BUTTON" {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            
            let lblQuestion : UILabel = cell.viewWithTag(1) as! UILabel
            let btnYes : UIButton = cell.viewWithTag(2) as! UIButton
            let btnNo : UIButton = cell.viewWithTag(3) as! UIButton
            
            lblQuestion.text = form.question
            btnYes.setTitle(form.titleQuestion1, for: .normal)
            btnNo.setTitle(form.titleQuestion2, for: .normal)
            
            btnYes.addTarget(self, action: #selector(responseYES(sender:)), for: .touchUpInside)
            btnNo.addTarget(self, action: #selector(responseNO(sender:)), for: .touchUpInside)
            
            if form.answer == "SI" {
                self.setSelectionButton(button: btnYes)
                self.setNotSelectionButton(button: btnNo)
            } else if form.answer == "NO" {
                self.setSelectionButton(button: btnNo)
                self.setNotSelectionButton(button: btnYes)
            } else {
                self.setNotSelectionButton(button: btnNo)
                self.setNotSelectionButton(button: btnYes)
            }
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            
            let lblQuestion : UILabel = cell.viewWithTag(10) as! UILabel
            let txt : UITextField = cell.viewWithTag(11) as! UITextField
            txt.delegate = self
            
            lblQuestion.text = form.question
            
            if form.typeKeyboard == "NUMBER" {
                txt.keyboardType = .phonePad
            } else if form.typeKeyboard == "DECIMAL" {
                txt.keyboardType = .phonePad
            } else if form.typeKeyboard == "DATE" {
                txt.keyboardType = .phonePad
            } else if form.typeKeyboard == "DATE_2" {
                txt.keyboardType = .phonePad
            } else {
                txt.keyboardType = .default
            }
            
            txt.text = form.answer
            txt.placeholder = form.titleQuestion1
            txt.addTarget(self, action: #selector(editingFields(sender:)), for: .editingChanged)
            txt.addTarget(self, action: #selector(endEditingFields(sender:)), for: .editingDidEndOnExit)
            txt.returnKeyType = .done
            
        }
        
        return cell
    }
    
    @objc func responseYES(sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.table)
        let indexPath = self.table.indexPathForRow(at: buttonPosition)
        if indexPath != nil {
            
            let form : Form = listSectionsForm[indexPath!.section].items[indexPath!.row]
            form.answer = "SI"
            table.reloadData()
            self.updateCar(form: form)
            
        }
    }
    
    @objc func responseNO(sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.table)
        let indexPath = self.table.indexPathForRow(at: buttonPosition)
        if indexPath != nil {
            
            let form : Form = listSectionsForm[indexPath!.section].items[indexPath!.row]
            form.answer = "NO"
            table.reloadData()
            self.updateCar(form: form)
            
        }
    }
    
    @objc func editingFields(sender: UITextField) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.table)
        let indexPath = self.table.indexPathForRow(at: buttonPosition)
        if indexPath != nil {
            
            let form : Form = listSectionsForm[indexPath!.section].items[indexPath!.row]
            
            if form.typeKeyboard == "DATE" {
                if (sender.text!.count > validateTextEditing){
                    validateTextEditing = sender.text!.count
                    if sender.text!.count == 2 {
                        sender.text = "\(sender.text!)/"
                    } else if sender.text!.count == 5 {
                        sender.text = "\(sender.text!)/"
                    }
                } else {
                    validateTextEditing = sender.text!.count
                    if sender.text!.count == 2 {
                        
                        let index = sender.text!.index(sender.text!.startIndex, offsetBy: 0)
                        let index2 = sender.text!.index(sender.text!.startIndex, offsetBy: validateTextEditing - 2)
                        let texto_extraido: String = String(sender.text![index...index2])
                        
                        sender.text = texto_extraido
                        
                    } else if sender.text!.count == 5 {
                        
                        let index = sender.text!.index(sender.text!.startIndex, offsetBy: 0)
                        let index2 = sender.text!.index(sender.text!.startIndex, offsetBy: validateTextEditing - 2)
                        let texto_extraido: String = String(sender.text![index...index2])
                        
                        sender.text = texto_extraido
                        
                    }
                    validateTextEditing = sender.text!.count
                }
                
            } else if form.typeKeyboard == "DATE_2" {
                if (sender.text!.count > validateTextEditing){
                    validateTextEditing = sender.text!.count
                    if sender.text!.count == 2 {
                        sender.text = "\(sender.text!)/"
                    }
                } else {
                    validateTextEditing = sender.text!.count
                    if sender.text!.count == 2 {
                        
                        let index = sender.text!.index(sender.text!.startIndex, offsetBy: 0)
                        let index2 = sender.text!.index(sender.text!.startIndex, offsetBy: validateTextEditing - 2)
                        let texto_extraido: String = String(sender.text![index...index2])
                        
                        sender.text = texto_extraido
                        
                    }
                    validateTextEditing = sender.text!.count
                }
                
            }
            
            form.answer = sender.text
            self.updateCar(form: form)
            
            print("editingFields \(form.question!) \(form.answer!)")
            
        }
    }
    
    @objc func endEditingFields(sender: UITextField) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.table)
        let indexPath = self.table.indexPathForRow(at: buttonPosition)
        if indexPath != nil {
            
            self.view.endEditing(true)
            
        }
    }
    
    func setSelectionButton(button : UIButton){
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setNotSelectionButton(button : UIButton){
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.black, for: .normal)
    }
    
    
}

extension FormViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPhoto", for: indexPath)
        
        let photo : UIImageView = cell.viewWithTag(20) as! UIImageView
        photo.image = UIImage(data: listPhotos[indexPath.row])
        
        let button : UIButton = cell.viewWithTag(21) as! UIButton
        button.addTarget(self, action: #selector(takePicture(sender:)), for: .touchUpInside)
        button.isHidden = true
        
        return cell
    }
    
    @objc func takePicture(sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.table)
        let indexPath = self.table.indexPathForRow(at: buttonPosition)
        if indexPath != nil {
            
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Select")
        self.indexPhoto = indexPath.row
        
        let message = "Fotos del auto"
        let alert = UIAlertController(title: "AutoClass", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tomar Foto", style: .default, handler: {_ in
            
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                Utils.showAlert(message: "Este dispositivo no tiene camara", VC: self)
            } else {
                
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
                
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Galeria", style: .default, handler: {_ in
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {_ in
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

extension FormViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagenPickerController : UIImage = info[.originalImage] as! UIImage
        
        if let imageData = imagenPickerController.jpegData(compressionQuality: 0.5) {
            print(imageData.count)
            
//            if self.indexPhoto == 0 {
//                self.car.foto1Datos = imageData
//            } else if self.indexPhoto == 1 {
//                self.car.foto2Datos = imageData
//            } else if self.indexPhoto == 2 {
//                self.car.foto3Datos = imageData
//            } else if self.indexPhoto == 3 {
//                self.car.foto4Datos = imageData
//            }
            
            self.listPhotos[self.indexPhoto] = imageData
            self.collection.reloadData()
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
