
import AVFoundation

protocol VideoSessionDelegate: class {
  
  func didStart(session: VideoSession)
  func didStop(session: VideoSession)
  func didFail(session: VideoSession)
  func videoSession(_ session: VideoSession, didReceiveBuffer buffer: Data)
  
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
    camera = AVCaptureDevice.default(for: .video)! //defaultDevice(withMediaType: AVMediaTypeVideo)
    input = try! AVCaptureDeviceInput(device: camera)
    output = AVCaptureVideoDataOutput()
    serialQueue = DispatchQueue(label: "CameraBufferQueue")
    previewLayer = AVCaptureVideoPreviewLayer(session: session)
    super.init()
    session.sessionPreset = AVCaptureSession.Preset.medium
    session.addInput(input)
    session.addOutput(output)
    output.videoSettings = [
      AVVideoCodecKey: AVVideoCodecH264
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
  
  func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
    let videoData = Data()
    DispatchQueue.main.async {
      self.delegate?.videoSession(self, didReceiveBuffer: videoData)
    }
  }
  
}
