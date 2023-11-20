//
//  ViewController.swift
//  Alamofire
//
//  Created by Huy Vu on 11/19/23.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var URL: UITextField!
    
    
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
    
    func downloadVideo(url: String, completion: @escaping (Data?) -> Void) {
        if let url = Foundation.URL(string: url) {
               URLSession.shared.dataTask(with: url) { (data, response, error) in
                   if let data = data {
                       completion(data)
                   } else {
                       print("Error downloading video: \(error?.localizedDescription ?? "Unknown error")")
                       completion(nil)
                   }
               }.resume()
           } else {
               print("Invalid URL")
               completion(nil)
           }
       }
    
    func saveVideoToDocuments(data: Data) {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let videoURL = documentsDirectory.appendingPathComponent("downloadedVideo.mp4")
            try data.write(to: videoURL)
            print("Video saved to: \(videoURL)")
        } catch {
            print("Error saving video: \(error.localizedDescription)")
        }
    }
    
    @IBAction func dowloadvideo(_ sender: Any) {
        guard let videoURL = URL.text, !videoURL.isEmpty else {
                    print("URL is empty.")
                    return
                }

        downloadVideo(url: videoURL) { data in
                    if let videoData = data {
                        // Handle video data here (e.g., save to a file)
                        // Make sure to check permissions before saving the video to the user's device
                        // ...
                        // Save the video to the Documents directory
                        self.saveVideoToDocuments(data: videoData)
                        print("Video downloaded successfully!")
                    } else {
                        print("Failed to download video.")
                    }
                }
    }
    
}

