
import VideoToolbox

class VideoEncoder {
  
  let session: VTCompressionSession
  
  init(width: Int32, height: Int32) {
    var session = nil as VTCompressionSession?
    VTCompressionSessionCreate(nil, width, height, kCMVideoCodecType_H264, nil, nil, nil, nil, nil, &session)
    /*
    let properties = [
      kVTPixelTransferPropertyKey_ScalingMode: nil,
      kVTPixelTransferPropertyKey_DestinationCleanAperture: nil,
      kVTPixelTransferPropertyKey_DestinationPixelAspectRatio: nil,
      kVTPixelTransferPropertyKey_DownsamplingMode: nil,
      kVTPixelTransferPropertyKey_DestinationColorPrimaries: nil,
      kVTPixelTransferPropertyKey_DestinationTransferFunction: nil,
      kVTPixelTransferPropertyKey_DestinationICCProfile: nil,
      kVTPixelTransferPropertyKey_DestinationYCbCrMatrix: nil,
      kVTCompressionPropertyKey_Depth: nil,
      kVTCompressionPropertyKey_ProfileLevel: nil,
      kVTCompressionPropertyKey_H264EntropyMode: nil,
      kVTCompressionPropertyKey_NumberOfPendingFrames: nil,
      kVTCompressionPropertyKey_PixelBufferPoolIsShared: nil,
      kVTCompressionPropertyKey_VideoEncoderPixelBufferAttributes: nil,
      kVTCompressionPropertyKey_AspectRatio16x9: nil,
      kVTCompressionPropertyKey_CleanAperture: nil,
      kVTCompressionPropertyKey_FieldCount: nil,
      kVTCompressionPropertyKey_FieldDetail: nil,
      kVTCompressionPropertyKey_PixelAspectRatio: nil,
      kVTCompressionPropertyKey_ProgressiveScan: nil,
      kVTCompressionPropertyKey_ColorPrimaries: nil,
      kVTCompressionPropertyKey_TransferFunction: nil,
      kVTCompressionPropertyKey_YCbCrMatrix: nil,
      kVTCompressionPropertyKey_ICCProfile: nil,
      kVTCompressionPropertyKey_ExpectedDuration: nil,
      kVTCompressionPropertyKey_ExpectedFrameRate: nil,
      kVTCompressionPropertyKey_SourceFrameCount: nil,
      kVTCompressionPropertyKey_AllowFrameReordering: nil,
      kVTCompressionPropertyKey_AllowTemporalCompression: nil,
      kVTCompressionPropertyKey_MaxKeyFrameInterval: nil,
      kVTCompressionPropertyKey_MaxKeyFrameIntervalDuration: nil,
      kVTCompressionPropertyKey_UsingHardwareAcceleratedVideoEncoder: nil,
      kVTCompressionPropertyKey_MultiPassStorage: nil,
      kVTCompressionPropertyKey_PixelTransferProperties: nil,
      kVTCompressionPropertyKey_AverageBitRate: nil,
      kVTCompressionPropertyKey_DataRateLimits: nil,
      kVTCompressionPropertyKey_MoreFramesAfterEnd: nil,
      kVTCompressionPropertyKey_MoreFramesBeforeStart: nil,
      kVTCompressionPropertyKey_Quality: nil,
      kVTCompressionPropertyKey_RealTime: nil,
      kVTCompressionPropertyKey_MaxH264SliceBytes: nil,
      kVTCompressionPropertyKey_MaxFrameDelayCount: nil,
      kVTCompressionPropertyKey_BaseLayerFrameRate: nil,
      kVTCompressionPropertyKey_MasteringDisplayColorVolume: nil,
      kVTCompressionPropertyKey_ContentLightLevelInfo: nil,
      kVTCompressionPropertyKey_EncoderID: nil,
      kVTEncodeFrameOptionKey_ForceKeyFrame: nil,
      kVTVideoEncoderSpecification_RequireHardwareAcceleratedVideoEncoder: nil,
      kVTVideoEncoderSpecification_EnableHardwareAcceleratedVideoEncoder: nil
    ] as CFDictionary
    VTSessionSetProperties(session!, properties)
 */
    self.session = session!
  }
  
  func encode(sampleBuffer: CMSampleBuffer, callback: @escaping (CMSampleBuffer) -> Void) {
    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return
    }
    let presentationTimeStamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
    let duration = CMSampleBufferGetDuration(sampleBuffer)
    let past = Date()
    VTCompressionSessionEncodeFrameWithOutputHandler(session, imageBuffer, presentationTimeStamp, duration, nil, nil) { status, flags, buffer in
      PrintExecutionTime(past: past)
      guard let buffer = buffer else {
        return
      }
      callback(buffer)
    }
  }
  
}

