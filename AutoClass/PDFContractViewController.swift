//
//  PDFContractViewController.swift
//  AutoClass
//
//  Created by Jonathan Fajardo Roa on 6/7/19.
//  Copyright © 2019 JFR. All rights reserved.
//

import UIKit
import WebKit
import MessageUI

class PDFContractViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, MFMailComposeViewControllerDelegate {

    var contract : Contract!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var url : String = "http://45.55.25.68/autoclass/form_pdf.php?contract_id=\(contract.id!)&car_id=\(contract.car_id!)&client_id=\(contract.client_id!)"
        let urlProccess : NSString = NSString(string: url)
        url = urlProccess.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let request : URLRequest = URLRequest(url: URL(string: url)!)
        webView.load(request)
        
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "PDF"
        
        let btnShare : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(sharePDF))
        self.navigationItem.rightBarButtonItem = btnShare
    }

    @objc func sharePDF(){
        
//        do {
//            let pdfFile : Data = try Data(contentsOf: webView.url!)
//            let activityItems = [pdfFile]
//            let activityViewControntroller = UIActivityViewController.init(activityItems: activityItems, applicationActivities: nil)
//            self.present(activityViewControntroller, animated: true, completion: nil)
//        } catch {
//
//        }
        do {
            let pdfFile : Data = try Data(contentsOf: webView.url!)
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([contract.client.mail])
                mail.setSubject("ContratoAutoClass\(contract.number!).pdf")
                mail.setMessageBody("<p>Contrato AutoClass!</p>", isHTML: true)
                mail.addAttachmentData(pdfFile, mimeType: "PDF", fileName: "ContratoAutoClass\(contract.number!).pdf")
                present(mail, animated: true)
            } else {
                // show failure alert
            }
        } catch {

        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        
        
        
    }
    
}
