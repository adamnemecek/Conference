
import AppKit
import AVFoundation

protocol VideoSessionDelegate: class {
  
  func didStart(session: VideoSession)
  func didStop(session: VideoSession)
  func didFail(session: VideoSession)
  func videoSession(_ session: VideoSession, didReceiveFrameBuffer buffer: Data)
  
}

class VideoSession: NSObject {
  
  let session: AVCaptureSession
  let camera: AVCaptureDevice
  let input: AVCaptureDeviceInput
  let output: AVCaptureVideoDataOutput
  let encoder: VideoEncoder
  let previewLayer: AVCaptureVideoPreviewLayer
  let serialQueue: DispatchQueue
  
  weak var delegate: VideoSessionDelegate?
  
  override init() {
    session = AVCaptureSession()
    camera = AVCaptureDevice.default(for: .video)!
    input = try! AVCaptureDeviceInput(device: camera)
    output = AVCaptureVideoDataOutput()
    encoder = VideoEncoder(width: 512, height: 512)
    previewLayer = AVCaptureVideoPreviewLayer(session: session)
    serialQueue = DispatchQueue(label: "CameraBufferQueue")
    super.init()
    session.addInput(input)
    session.addOutput(output)
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
    let past = Date()
    encoder.encode(sampleBuffer: sampleBuffer) { sampleBuffer in
      PrintExecutionTime(past: past)
      guard let data = VideoFrameEncodeBinary(sampleBuffer: sampleBuffer) else {
        return
      }
      DispatchQueue.main.async {
        self.delegate?.videoSession(self, didReceiveFrameBuffer: data)
      }
    }
  }
  
}
