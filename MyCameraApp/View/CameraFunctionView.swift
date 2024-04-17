//
//  ContentView.swift
//  MyCameraApp
//
//  Created by t&a on 2024/04/17.
//

import SwiftUI

struct CameraFunctionView: View {
    
    @ObservedObject private var viewModel = CameraFunctionViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if let image = viewModel.image {
                
                Image(uiImage: image)
                    .resizable()
                    .frame(width: DeviceSizeManager.deviceWidth, height: (4 / 3) * DeviceSizeManager.deviceWidth)
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        self.viewModel.image = nil
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundStyle(.white)
                    }.frame(width: 40)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .overlay {
                                RoundedRectangle(cornerRadius: 80)
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 80, height: 80)
                            }.padding(.bottom, 10)
                    }
                    
                    Spacer()
                    
                    Spacer()
                        .frame(width: 40)
                        .padding(.trailing, 20)
                }.padding(.bottom)
                
            } else {
                
                if let previewLayer = viewModel.previewLayer {
                    CALayerView(caLayer: previewLayer)
                }
                
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.viewModel.takePhoto()
                    }) {
                        Image(systemName: "camera")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 40)
                            .overlay {
                                RoundedRectangle(cornerRadius: 80)
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 80, height: 80)
                            }.padding(.bottom, 10)
                    }
                    Spacer()
                }.padding(.bottom)
                
            }
        }.background(Color.black)
            .onAppear {
                self.viewModel.startSession()
            }.onDisappear {
                self.viewModel.endSession()
            }
    }
}

#Preview {
    CameraFunctionView()
}
