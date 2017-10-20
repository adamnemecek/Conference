
import VideoToolbox

class VideoEncoder {
  
  init(width: Int32, height: Int32) {
    VTCompressionSessionCreate(nil, width, height, kCMVideoCodecType_H264, nil, nil, nil, <#T##outputCallback: VTCompressionOutputCallback?##VTCompressionOutputCallback?##(UnsafeMutableRawPointer?, UnsafeMutableRawPointer?, OSStatus, VTEncodeInfoFlags, CMSampleBuffer?) -> Void#>, <#T##outputCallbackRefCon: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>, <#T##compressionSessionOut: UnsafeMutablePointer<VTCompressionSession?>##UnsafeMutablePointer<VTCompressionSession?>#>)
  }
  
}
