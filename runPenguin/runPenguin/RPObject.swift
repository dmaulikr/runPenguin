//
//  RPObject.swift
//  runPenguin
//
//  Created by Dev Workstation02 on 6/29/16.
//  Copyright © 2016 Jordan. All rights reserved.
//

import UIKit
import SpriteKit

class RPObject: SKSpriteNode {
    
    var frames: [SKTexture] = []
    
    init(initalImage:String, prefix: String , bitmask: UInt32 ) {
        
        let atlas = SKTextureAtlas(named:prefix)
        
        let numPieces = atlas.textureNames.count
        
        // read images into array
    
        let initialFrame = SKTexture(imageNamed: initalImage)
        
        super.init(texture: initialFrame, color: UIColor.blackColor(), size: initialFrame.size())
        
        populateFrames(frames,prefix: prefix,numFrames: numPieces)
        
        self.physicsBody?.categoryBitMask = bitmask
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateFrames(frames: [SKTexture], prefix: String,numFrames: Int){
        
        for i in 0 ..< numFrames {
            var name: String = "Filename"
            if numFrames>100{
                name = "\(prefix)\(String(format: "%03d", i))"
            }
            if numFrames>=10{
                name = "\(prefix)\(String(format: "%02d", i))"
            }
            if numFrames<10{
                name = "\(prefix)\(String(format: "%01d", i))"
            }
            
            self.frames.append(SKTexture(imageNamed: name))
        }
        
    }
    
    func place(scene: SKScene,sprite: SKSpriteNode, x: CGFloat,y: CGFloat, path: CGPath){
        
        sprite.position = CGPoint(x: x, y: y)
        
        sprite.accessibilityPath?.CGPath = path
        
        scene.addChild(sprite)
    }
    func place(scene: SKScene,sprite: SKSpriteNode, x: CGFloat,y: CGFloat){
        
        sprite.position = CGPoint(x: x, y: y)
        
        scene.addChild(sprite)
    }
    
    internal func place(scene: SKScene, x: CGFloat ,y:CGFloat,path: CGPath){
        place(scene, sprite: self, x: x, y: y, path: path)
    }
    
   internal func place(scene: SKScene, x: CGFloat,y: CGFloat){
    
        place(scene, sprite: self, x: x, y: y)
    
    }
    

    
    func setPhysics (sprite: SKSpriteNode ,dynamic: Bool, texture: SKTexture, mass: CGFloat, friction: CGFloat, bitmask: UInt32){
        
        
        sprite.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        
        sprite.physicsBody!.dynamic = dynamic
        
        sprite.physicsBody!.mass = CGFloat(mass)
        
        sprite.physicsBody!.friction = CGFloat(friction)
        
        sprite.physicsBody?.categoryBitMask = bitmask
        
    }

}
