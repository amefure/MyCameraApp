//
//  CameraFunctionViewModel.swift
//  MyCameraApp
//
//  Created by t&a on 2024/04/17.
//

import UIKit
import Combine

class CameraFunctionViewModel: ObservableObject {
    
    // MARK: - Model
    @Published var image: UIImage?
    @Published var previewLayer: CALayer?
    
    // MARK: - Repository
    private var cameraRepository = CameraFunctionRepository()
    
    // MARK: - Combine
    private var cancellables:Set<AnyCancellable> = Set()

    init() {
        cameraRepository.image.sink { [weak self] image in
            guard let self else { return }
            self.image = image
        }.store(in: &cancellables)
        
        cameraRepository.previewLayer.sink { [weak self] previewLayer in
            guard let self else { return }
            self.previewLayer = previewLayer
        }.store(in: &cancellables)
        
        cameraRepository.prepareSetting()
    }
}

// MARK: - カメラ機能
extension CameraFunctionViewModel {
    /// 写真撮影
    public func takePhoto() {
        cameraRepository.takePhoto()
    }
    /// セッション開始
    public func startSession() {
        cameraRepository.startSession()
    }
    /// セッション終了
    public func endSession() {
        cameraRepository.endSession()
    }
}
