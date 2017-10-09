
import AppKit
import AVFoundation

protocol VideoSessionDelegate: class {
  
  func didStart(session: VideoSession)
  func didStop(session: VideoSession)
  func didFail(session: VideoSession)
  func videoSession(_ session: VideoSession, didReceiveBuffer buffer: [UInt8])
  
}

class VideoSession: NSObject {
  
  let session: AVCaptureSession
  let camera: AVCaptureDevice
  let input: AVCaptureDeviceInput
  let output: AVCaptureVideoDataOutput
  let serialQueue: DispatchQueue
  let previewLayer: AVCaptureVideoPreviewLayer
  
  weak var delegate: VideoSessionDelegate?
  
  override init() {
    session = AVCaptureSession()
    camera = AVCaptureDevice.default(for: .video)!
    input = try! AVCaptureDeviceInput(device: camera)
    output = AVCaptureVideoDataOutput()
    serialQueue = DispatchQueue(label: "CameraBufferQueue")
    previewLayer = AVCaptureVideoPreviewLayer(session: session)
    super.init()
    session.addInput(input)
    session.addOutput(output)
    output.videoSettings = [
      AVVideoCodecKey: AVVideoCodecType.hevc,
      AVVideoCompressionPropertiesKey: [
        AVVideoAverageBitRateKey: 256000
      ]
    ]
    output.setSampleBufferDelegate(self, queue: serialQueue)
    NotificationCenter.default.addObserver(forName: .AVCaptureSessionDidStartRunning, object: session, queue: nil) { notification in
      self.delegate?.didStart(session: self)
    }
    NotificationCenter.default.addObserver(forName: .AVCaptureSessionDidStopRunning, object: session, queue: nil) { notification in
      self.delegate?.didStop(session: self)
    }
    NotificationCenter.default.addObserver(forName: .AVCaptureSessionRuntimeError, object: session, queue: nil) { notification in
      self.delegate?.didFail(session: self)
    }
  }
  
  func start() {
    serialQueue.async {
      self.session.startRunning()
    }
  }
  
  func stop() {
    serialQueue.async {
      self.session.stopRunning()
    }
  }
  
}

extension VideoSession: AVCaptureVideoDataOutputSampleBufferDelegate {
  
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    
  }
  
}
