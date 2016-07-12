//
//  object.swift
//  runPenguin
//
//  Created by Dev Workstation02 on 6/28/16.
//  Copyright © 2016 Jordan. All rights reserved.
//

import UIKit
import SpriteKit

class obsticle: RPObject {
    
    var defaults: [Double] = [-5,-45,1,1,5,40,1,1,3,16,1,1,11,6,1,1]
    var pieces: [SKSpriteNode] = []
    // initalizers
    
    // base initalizer
    init(){
        super.init(initalImage: "object_icicle00",prefix: "icicle_pieces", bitmask: 2)
        setPieces()
    }
    // initalizer to place object
    init(scene:SKScene, x: CGFloat, y: CGFloat){
        super.init(initalImage: "object_icicle00",prefix: "icicle_pieces", bitmask: 2)
        place(scene,x:x, y: y)
        setPieces()
    }
    
    // initalizer to place object and set on pate
    init(scene: SKScene, x: CGFloat,y: CGFloat,path: CGPath){
        super.init(initalImage: "object_icicle00",prefix: "icicle_pieces", bitmask: 2)
        place(scene,x: x, y: y, path: path)
        setPieces()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // sets the pieces physics
    func setPieces(){
        for i in 0 ..< frames.count{
            
            let sprite = SKSpriteNode(texture: frames[i])
            
            setPhysics(sprite,
                       dynamic: false,
                       texture: frames[i],
                       mass: CGFloat(self.defaults[(i*4)+2]),
                       friction: CGFloat(self.defaults[(i*4)+3]),
                       bitmask: 3
                    )
            
            pieces.append(sprite)
            
            }
        
    }
    
    //places the pieces
    func Break(){
        
        // set original node to base texture and resize
        self.texture = frames[0]
        self.size = frames[0].size()
        // move it to the proper position
        self.position = CGPointMake(self.position.x + CGFloat(self.defaults[0]), self.position.y + CGFloat(self.defaults[1]))
        // place the rest of the nodes
        for i in 1 ..< frames.count{
            
            place(self.scene!,sprite: pieces[i],x: self.position.x + CGFloat(self.defaults[(i*4)]),y: self.position.y + CGFloat(self.defaults[(i*4)+1]))
            
        }
        
    }
    
    
}

