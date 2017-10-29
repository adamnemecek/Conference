
import VideoToolbox

class VideoEncoder {
  
  let session: VTCompressionSession
  
  init(width: Int32, height: Int32) {
    var session = nil as VTCompressionSession?
    let encoderSpecification = [
      kVTVideoEncoderSpecification_EnableHardwareAcceleratedVideoEncoder: kCFBooleanTrue,
      kVTVideoEncoderSpecification_RequireHardwareAcceleratedVideoEncoder: kCFBooleanTrue,
    ] as CFDictionary
    VTCompressionSessionCreate(nil, width, height, kCMVideoCodecType_H264, encoderSpecification, nil, nil, nil, nil, &session)
    let properties = [
      kVTCompressionPropertyKey_AverageBitRate: 1024_000,
      kVTCompressionPropertyKey_ProfileLevel: kVTProfileLevel_H264_Baseline_AutoLevel,
      kVTCompressionPropertyKey_RealTime: kCFBooleanTrue,
      kVTCompressionPropertyKey_ExpectedFrameRate: 24,
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

