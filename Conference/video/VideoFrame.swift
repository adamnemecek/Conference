
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
  let duration: VideoFrameTimeStamp
  let presentationTime: VideoFrameTimeStamp
  
  init?(sampleBuffer: CMSampleBuffer) {
    let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)
    print(formatDescription!)
    guard let blockBuffer = CMSampleBufferGetDataBuffer(sampleBuffer) else {
      return nil
    }
    let durationRaw = CMSampleBufferGetDuration(sampleBuffer)
    let presentationTimeRaw = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
    self.buffer = VideoFrameBlockBufferToByteBuffer(blockBuffer: blockBuffer)
    self.duration = VideoFrameTimeStamp(time: durationRaw)
    self.presentationTime = VideoFrameTimeStamp(time: presentationTimeRaw)
  }
  
  func sampleBuffer() -> CMSampleBuffer {
    let blockBufferRaw = VideoFrameByteBufferToBlockBuffer(buffer: buffer)
    let durationRaw = duration.timeRaw()
    let presentationTimeRaw = presentationTime.timeRaw()
    var timingInfo = CMSampleTimingInfo(duration: durationRaw, presentationTimeStamp: presentationTimeRaw, decodeTimeStamp: kCMTimeInvalid)
    var bufferSize = buffer.count
    var sampleBuffer : CMSampleBuffer?
    CMSampleBufferCreateReady(kCFAllocatorDefault, blockBufferRaw, nil, 1, 1, &timingInfo, 1, &bufferSize, &sampleBuffer)
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
