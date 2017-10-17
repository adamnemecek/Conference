
import AVFoundation

struct VideoFrameTimeStamp {
  
  let value: UInt64
  let timescale: UInt64
  
  init(time: CMTime) {
    value = UInt64(time.value)
    timescale = UInt64(time.timescale)
  }
  
  func timeRaw() -> CMTime {
    let valueRaw = CMTimeValue(value)
    let timescaleRaw = CMTimeScale(timescale)
    return CMTime(value: valueRaw, timescale: timescaleRaw)
  }
  
}

struct VideoFrame {
  
  let buffer: [UInt8]
  let extensions: Data
  let duration: VideoFrameTimeStamp
  let presentationTime: VideoFrameTimeStamp
  let width: Int32
  let height: Int32
  
  init?(sampleBuffer: CMSampleBuffer) {
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
    let durationRaw = CMSampleBufferGetDuration(sampleBuffer)
    let presentationTimeRaw = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
    self.buffer = VideoFrameBlockBufferToByteBuffer(blockBuffer: blockBuffer)
    self.extensions = NSKeyedArchiver.archivedData(withRootObject: extensions)
    self.duration = VideoFrameTimeStamp(time: durationRaw)
    self.presentationTime = VideoFrameTimeStamp(time: presentationTimeRaw)
    self.width = dimensions.width
    self.height = dimensions.height
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

func VideoFrameBlockBufferToByteBuffer(blockBuffer: CMBlockBuffer) -> [UInt8] {
  let length = CMBlockBufferGetDataLength(blockBuffer)
  var byteBuffer = [UInt8](repeating: 0, count: length)
  CMBlockBufferCopyDataBytes(blockBuffer, 0, length, &byteBuffer)
  return byteBuffer
}

func VideoFrameByteBufferToBlockBuffer(buffer: [UInt8]) -> CMBlockBuffer {
  var blockBuffer = nil as CMBlockBuffer?
  CMBlockBufferCreateWithMemoryBlock(nil, nil, buffer.count, nil, nil, 0, buffer.count, 0, &blockBuffer)
  CMBlockBufferReplaceDataBytes(buffer, blockBuffer!, 0, buffer.count)
  return blockBuffer!
}
