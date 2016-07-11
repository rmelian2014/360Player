//
//  AVURLAsset+Extension.swift
//  360Player
//
//  Created by Alfred Hanssen on 7/7/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import AVFoundation

extension AVURLAsset
{
    /**
     Returns the encoded resolution of the asset or nil if the asset does not contain a video track. The encoded resolution is the `preferredTransform` applied to the `naturalSize`.
     
     - returns: The encoded resolution or `nil`.
     */
    func encodedResolution() -> CGSize?
    {
        guard let track = self.tracksWithMediaType(AVMediaTypeVideo).first else
        {
            return nil
        }
        
        let naturalSize = track.naturalSize
        let preferredTransform = track.preferredTransform
        let size = CGSizeApplyAffineTransform(naturalSize, preferredTransform)
        
        let width = fabs(size.width)
        let height = fabs(size.height)
        
        return CGSize(width: width, height: height)
    }
}