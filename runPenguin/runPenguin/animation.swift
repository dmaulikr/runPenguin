//
//  animation.swift
//  runPenguin
//
//  Created by Dev Workstation02 on 6/23/16.
//  Copyright © 2016 Jordan. All rights reserved.
//

import SpriteKit

class animation {
    
    var prefix: String = "prefix"
    var sprite: SKSpriteNode?
    var frames = [SKTexture]()
    var atlas = SKTextureAtlas()
    var numFrames: Int = 0
    var key: String = "key"
    var action: SKAction!
 
    
    
    func set(prefix: String, spriteNode: SKSpriteNode,fps: Double) {
        
        self.prefix = prefix
        self.sprite = spriteNode

        
        
        self.atlas = SKTextureAtlas(named: self.prefix)
        
        self.numFrames = atlas.textureNames.count
        
        var i = 0
        
        repeat{
            let name = "\(self.prefix)_\(i)"
            
            frames.append(self.atlas.textureNamed(name))
            
            print(name)
            print(frames[i])
            
            i = i + 1
        }
        while i < self.numFrames
        
        
        self.sprite?.texture = frames[0]
        
        setAnimation(fps)
        
    }
    
    func setAnimation(fps: Double) {
        //This is our general runAction method to make our bear walk.
        
        self.action = SKAction.animateWithTextures(frames,
                timePerFrame: (1/fps),
                resize: false,
                restore: true)
    }
    
    func animate(loop: Bool,key: String){
        if loop{
        self.sprite?.runAction(SKAction.repeatActionForever(self.action), withKey: key)
        }
        else{
            
        self.sprite?.runAction(self.action, withKey: key)
        self.sprite?.texture = frames[numFrames-1]
            
        }
        
    }
    
}
