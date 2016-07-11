//
//  VideoScene.swift
//  360Player
//
//  Created by Alfred Hanssen on 7/10/16.
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

import UIKit
import SceneKit
import SpriteKit
import AVFoundation

class VideoScene: SCNScene
{
    /// The radius of the sphere on which we project the video texture.
    static let SphereRadius: CGFloat = 100 // TODO: How to choose the sphere radius? [AH] 7/7/2016

    /// The video player responsible for playback of our video content.
    let player: AVPlayer
    
    /// The camera node located at the center of our sphere whose camera property is the user's view point.
    let cameraNode: SCNNode

    convenience init(URL: NSURL)
    {
        let player = AVPlayer(URL: URL)
        self.init(AVPlayer: player)
    }

    convenience init(playerItem item: AVPlayerItem)
    {
        let player = AVPlayer(playerItem: item)
        self.init(AVPlayer: player)
    }
    
    override convenience init()
    {
        let player = AVPlayer()

        self.init(AVPlayer: player)
        
//        let url = NSURL.fileURLWithPath(path)
//        let urlAsset = AVURLAsset(URL: url)
//        guard let size = urlAsset.encodedResolution() else // TODO: Does this capture screen scale? [AH] 7/7/2016
//        {
//            assertionFailure("Unable to access encoded resolution for video resource.")
//            
//            return
//        }

    }
    
    init(AVPlayer player: AVPlayer)
    {
        self.player = player

        let size = CGSize.zero
        
        //        self.player = AVPlayer(URL: url)
        
        // Video node
        let videoNode = SKVideoNode(AVPlayer: player)
        videoNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        videoNode.size = size
        videoNode.yScale = -1 // Flip the video so it appears right side up
        
        // SKScene
        let skScene = SKScene(size: size)
        skScene.scaleMode = .AspectFit
        skScene.addChild(videoNode)
        
        // Material
        let material = SCNMaterial()
        material.diffuse.contents = skScene
        material.cullMode = .Front // Ensure that the material renders on the inside of our sphere
        
        // Sphere geometry
        let sphere = SCNSphere(radius: self.dynamicType.SphereRadius)
        sphere.firstMaterial = material
        
        // Geometry node
        let geometryNode = SCNNode(geometry: sphere)
        geometryNode.position = SCNVector3Zero
        
        // Camera
        let camera = SCNCamera()
        camera.automaticallyAdjustsZRange = true
        
        // Camera node
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3Zero
        self.cameraNode = cameraNode

        super.init()

        self.rootNode.addChildNode(geometryNode)
        self.rootNode.addChildNode(cameraNode)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
