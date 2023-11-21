//
//  ViewController.swift
//  Alamofire
//
//  Created by Huy Vu on 11/19/23.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var URL: UITextField!
    
    @IBOutlet weak var URl_text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print("Documents Directory: \(documentsDirectory)")
        } else {
            print("Could not retrieve documents directory.")
        }

    }

    @IBAction func Pateok(_ sender: Any) {
        URL.resignFirstResponder()
        if let pasteboardString = UIPasteboard.general.string {
            URL.text = pasteboardString
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        URL.text = "" // Gán giá trị cho UITextField thành chuỗi rỗng để xoá dữ liệu
    }
    
   
    
   
    
    @IBAction func dowloadvideo(_ sender: Any) {
        // Lấy giá trị từ UITextField
        if let urlText = URL.text {
            // Sử dụng regular expression để lọc đường dẫn mong muốn
            if let extractedURL = extractURL(from: urlText) {
                URl_text.text = extractedURL
                print(extractedURL)
            } else {
                URl_text.text = urlText
            }
        }
    }
    
    
    // Hàm để lọc đường dẫn từ văn bản đầu vào
       func extractURL(from text: String) -> String? {
           // Sử dụng regular expression để tìm kiếm đường dẫn
           let pattern = "https://v.douyin.com/[a-zA-Z0-9/]+"
           
           do {
               let regex = try NSRegularExpression(pattern: pattern)
               let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
               
               if let match = matches.first {
                   return String(text[Range(match.range, in: text)!])
               }
           } catch {
               print("Error in regular expression: \(error)")
           }
           
           return nil
       }
    
}

