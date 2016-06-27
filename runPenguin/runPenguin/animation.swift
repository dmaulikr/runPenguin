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
    var sprite: SKSpriteNode!
    var frames = [SKTexture]()
    var atlas = SKTextureAtlas()
    var numFrames: Int = 0
    var key: String = "key"
    var action: SKAction!
    var FPS: Double = 0
 
    
    // sets the parameters of the new animation along with optional values
    // prefix is just the folder name - .atlas the sprite node is where you want the animation to play
    
    
    func set(prefix: String,spriteNode: SKSpriteNode, fps: Double = 1,play: Bool=false,loop: Bool=false) {
        
        self.prefix = prefix
        
        
        self.atlas = SKTextureAtlas(named: self.prefix)
        self.sprite = spriteNode

        
        self.numFrames = atlas.textureNames.count
        print(self.numFrames)
        
        // grab default fps data
        let file = "/Users/dev02/Documents/runPenguin/runPenguin/runPenguin/\(prefix).atlas/\(prefix)_fps"
        
        do {
            // Get the contents
            let contents = try NSString(contentsOfFile: file, encoding: NSUTF8StringEncoding) as String
            print(contents)
            self.FPS = Double(contents)!
            print(self.FPS)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
        // allow for custom fps
        
        if fps != 1{
            self.FPS = fps
        }
        
        // read images into array
        
        var i = 0
        var name: String = "filename"
        
        repeat{
            if self.numFrames>100{
                name = "\(self.prefix)\(String(format: "%03d", i))"
            }
            if self.numFrames>=10{
                name = "\(self.prefix)\(String(format: "%02d", i))"
            }
            if self.numFrames<10{
                name = "\(self.prefix)\(String(format: "%01d", i))"
            }
            if self.sprite == nil{
                print("sprite is nil")
            }
            
            frames.append(self.atlas.textureNamed(name))
            
            print(name)
            print(frames[i])
            
            i = i + 1
        }
        while i < self.numFrames
        
        
        
        
        self.sprite?.texture = frames[0]
        
        // setup animation
        
        setAnimation(FPS)
        
        // start play on setup
        
        if (play == true) {
            animate(loop)
        }
    }
    
    // sets the animation action
    
    func setAnimation(fps: Double = 1) {
        
        if fps != 1{
            self.FPS = fps
        }
        
        //This is our general runAction method to make our bear walk.
        
        self.action = SKAction.animateWithTextures(frames,
                timePerFrame: (1/fps),
                resize: false,
                restore: true)
    }
    
    // play the animation and loop if nessisary
    
    func animate(loop: Bool){
        if loop{
        self.sprite?.runAction(SKAction.repeatActionForever(self.action), withKey: prefix)
        }
        else{
            
        self.sprite?.runAction(self.action, withKey: prefix)
        self.sprite?.texture = frames[numFrames-1]
            
        }
        
    }
    
}
