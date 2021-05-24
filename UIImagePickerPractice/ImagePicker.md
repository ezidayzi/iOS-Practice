
#### ✨info.plist에 추가해주기
<img width="60%" alt="스크린샷 2021-05-24 오후 2 32 01" src="https://user-images.githubusercontent.com/72497599/119301325-3df0a300-bc9d-11eb-8e63-81d95628b822.png">

```swift
//
//  ViewController.swift
//  UIImagePickerPractice
//
//  Created by 김윤서 on 2021/05/22.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate{

    private let imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction private func pickImage(_ sender: Any) {
        print("\n---------- [ pickImage ] ----------\n")
        
        //간단히 present만으로 imagePickerController를 띄울수 있다.
        //present(imagePickerController, animated: true, completion: nil)
        
        /*
        public enum UIImagePickerControllerSourceType : Int {
            case photoLibrary // 사진 앨범들
            case camera // 카메라를 띄우는 타입
            case savedPhotosAlbum // 특별한 순간
        }
         */
        
        let type = UIImagePickerController.SourceType.photoLibrary
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return } // 현재 기기에서 가능한지 확인하는 부분
        
        imagePickerController.sourceType = type
        present(imagePickerController, animated: true, completion: nil)
      }
    
    @IBAction private func takePicture(_ sender: Any) {
        print("\n---------- [ takePicture ] ----------\n")
        
        //카메라 사용가능한지 체크
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        imagePickerController.sourceType = .camera
        
        //imagePickerController.allowsEditing = true // 촬영 후 편집할 수 있는 부분이 나온다.
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction private func takePictureWithDelay(_ sender: Any) {
        print("\n---------- [ takePictureWithDelay ] ----------\n")

        //카메라 사용가능한지 체크
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        imagePickerController.sourceType = .camera

        // 클로저를 이용해서 3초 뒤에 나오게 처리
        // 클로저 안에 클로저를 쓸때 self를 쓰게되면 강한 참조가 발생한다.
        // 그래서 이럴때는 weak self 캡처링을 이용해서 약한참조로 만들어준다.
        present(imagePickerController, animated: true) { [weak self] in
            
            // 클로저를 이용한 방법
            // 화면이 올라오자마자 바로 찍히게됨.
            // self.imagePickerController.takePicture()
            
            //3초 뒤에 찍히게.
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self?.imagePickerController.takePicture() // 여기서는 강한 참조가 발생해서 weak self를 캡처링
            })
        }
    }
    
    @IBAction private func recordingVideo(_ sender: Any) {
        print("\n---------- [ recordingVideo ] ----------\n")

        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        imagePickerController.sourceType = .camera

        imagePickerController.mediaTypes = ["public.movie"] // 추가
        imagePickerController.cameraCaptureMode = .video

        // 카메라 정면, 후면 설정
        imagePickerController.cameraDevice = .rear // 후면     .rear, .front
        // 플래쉬 작동 모드
        imagePickerController.cameraFlashMode = .on // FlashMode  .on, .off, .auto


        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction private func toggleAllowsEditing(_ sender: Any) {
        print("\n---------- [ toggleAllowsEditing ] ----------\n")
        
        // 누를때 마다 반대가 되게
        imagePickerController.allowsEditing = !imagePickerController.allowsEditing
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        // Do any additional setup after loading the view.
    }

}

extension ViewController : UIPickerViewAccessibilityDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        //info에 정보들이 들어있다! Dictionary타입
        print("didFinishPickingMediaWithInfo,", info)

        let mediaType = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaType.rawValue)] as! NSString

        // 1번!!!!!!!!!
        if UTTypeEqual(mediaType, kUTTypeMovie) {
            // 동영상 촬영 정보가 넘어 옴

            let urlPath = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaURL.rawValue)] as! NSURL
            if let path = urlPath.path {
                // video를 저장하는 메서드
                UISaveVideoAtPathToSavedPhotosAlbum(path, nil, nil, nil)
            }
        } else {
            // 사진 촬영, 이미지 정보가 넘어옴
            let originalImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as! UIImage // as? UIImage를 해도된다.
            let editedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue)] as? UIImage
                let selectedImage = editedImage ?? originalImage // editedImage가 nil이면 originalImage를 넣으라는 뜻
                imageView.image = selectedImage
                

                //2번!!!!!!!!!!!
                UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil) // 이미지를 저장하는 메서드
                print(selectedImage)
                
                // Delegate 메서드가 구현되어 있지 않을 때는 기본적으로 선택시 종료되도록 기본 구현이 되어있음. ( 그래서 dismiss를 해주어야된다. )
            picker.dismiss(animated: true, completion: nil)
        }
    }
}







```
