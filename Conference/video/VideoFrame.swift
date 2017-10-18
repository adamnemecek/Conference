
import Foundation
import AVFoundation

func VideoFrameEncodeBinary(sampleBuffer: CMSampleBuffer) -> Data? {
  guard let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer) else {
    return nil
  }
  guard let blockBuffer = CMSampleBufferGetDataBuffer(sampleBuffer) else {
    return nil
  }
  guard let extensions = CMFormatDescriptionGetExtensions(formatDescription) else {
    return nil
  }
  let dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
  let duration = CMSampleBufferGetDuration(sampleBuffer)
  let presentationTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
  let length = CMBlockBufferGetDataLength(blockBuffer)
  var byteBuffer = [UInt8](repeating: 0, count: length)
  CMBlockBufferCopyDataBytes(blockBuffer, 0, length, &byteBuffer)
  let payload = [
    "blockBuffer": byteBuffer,
    "extensions": extensions,
    "width": dimensions.width,
    "height": dimensions.height,
    "durationValue": duration.value,
    "durationTimescale": duration.timescale,
    "presentationTimeValue": presentationTime.value,
    "presentationTimeTimescale": presentationTime.timescale
  ] as [String: Any]
  return NSKeyedArchiver.archivedData(withRootObject: payload)
}

func VideoFrameDecodeBinary(data: Data) -> CMSampleBuffer? {
//  let payload = NSKeyedUnarchiver.unarchiveObject(with: data) as! [String: Any]
//  let extensions = payload["extensions"] as! Dictionary
  return nil
}

/*
struct VideoFrame {
  

  
  init?(sampleBuffer: CMSampleBuffer) {

  }
  
  func sampleBuffer() -> CMSampleBuffer {
    let extensions = NSKeyedUnarchiver.unarchiveObject(with: self.extensions) as! CFDictionary
    let blockBufferRaw = VideoFrameByteBufferToBlockBuffer(buffer: buffer)
    var formatDescription = nil as CMFormatDescription?
    CMVideoFormatDescriptionCreate(kCFAllocatorDefault, kCMVideoCodecType_H264, width, height, extensions, &formatDescription)
    let durationRaw = duration.timeRaw()
    let presentationTimeRaw = presentationTime.timeRaw()
    var timingInfo = CMSampleTimingInfo(duration: durationRaw, presentationTimeStamp: presentationTimeRaw, decodeTimeStamp: kCMTimeInvalid)
    var bufferSize = buffer.count
    var sampleBuffer : CMSampleBuffer?
    CMSampleBufferCreateReady(kCFAllocatorDefault, blockBufferRaw, formatDescription, 1, 1, &timingInfo, 1, &bufferSize, &sampleBuffer)
    return sampleBuffer!
  }
  
}



func VideoFrameByteBufferToBlockBuffer(buffer: [UInt8]) -> CMBlockBuffer {
  var blockBuffer = nil as CMBlockBuffer?
  CMBlockBufferCreateWithMemoryBlock(nil, nil, buffer.count, nil, nil, 0, buffer.count, 0, &blockBuffer)
  CMBlockBufferReplaceDataBytes(buffer, blockBuffer!, 0, buffer.count)
  return blockBuffer!
}
 
*/
