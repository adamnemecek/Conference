
import VideoToolbox

class VideoEncoder {
  
  let session: VTCompressionSession
  
  init(width: Int32, height: Int32) {
    var session = nil as VTCompressionSession?
    VTCompressionSessionCreate(nil, width, height, kCMVideoCodecType_H264, nil, nil, nil, nil, nil, &session)
    let properties = [
      kVTCompressionPropertyKey_RealTime: kCFBooleanTrue,
      kVTCompressionPropertyKey_AverageBitRate: 512000,
      kVTCompressionPropertyKey_ExpectedFrameRate: 24
    ] as CFDictionary
    VTSessionSetProperties(session!, properties)
    self.session = session!
  }
  
  func encode(sampleBuffer: CMSampleBuffer, callback: @escaping (CMSampleBuffer) -> Void) {
    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return
    }
    let presentationTimeStamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
    let duration = CMSampleBufferGetDuration(sampleBuffer)
    VTCompressionSessionEncodeFrameWithOutputHandler(session, imageBuffer, presentationTimeStamp, duration, nil, nil) { status, flags, buffer in
      guard let buffer = buffer else {
        return
      }
      callback(buffer)
    }
  }
  
}
