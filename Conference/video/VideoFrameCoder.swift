
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
  let payload = NSKeyedUnarchiver.unarchiveObject(with: data) as! [String: Any]
  let byteBuffer = payload["blockBuffer"] as! [UInt8]
  let extensions = payload["extensions"] as! CFDictionary
  let width = payload["width"] as! Int32
  let height = payload["height"] as! Int32
  let durationValue = payload["durationValue"] as! CMTimeValue
  let durationTimescale = payload["durationTimescale"] as! CMTimeScale
  let presentationTimeValue = payload["presentationTimeValue"] as! CMTimeValue
  let presentationTimeTimescale = payload["presentationTimeTimescale"] as! CMTimeScale
  
  var blockBuffer = nil as CMBlockBuffer?
  CMBlockBufferCreateWithMemoryBlock(nil, nil, byteBuffer.count, nil, nil, 0, byteBuffer.count, 0, &blockBuffer)
  CMBlockBufferReplaceDataBytes(byteBuffer, blockBuffer!, 0, byteBuffer.count)
  
  let duration = CMTime(value: durationValue, timescale: durationTimescale)
  let presentationTime = CMTime(value: presentationTimeValue, timescale: presentationTimeTimescale)
  var timingInfo = CMSampleTimingInfo(duration: duration, presentationTimeStamp: presentationTime, decodeTimeStamp: kCMTimeInvalid)
  
  var formatDescription = nil as CMFormatDescription?
  CMVideoFormatDescriptionCreate(kCFAllocatorDefault, kCMVideoCodecType_H264, width, height, extensions, &formatDescription)
  
  var bufferSize = byteBuffer.count
  var sampleBuffer : CMSampleBuffer?
  CMSampleBufferCreateReady(kCFAllocatorDefault, blockBuffer, formatDescription, 1, 1, &timingInfo, 1, &bufferSize, &sampleBuffer)
  return sampleBuffer
}
