import SpriteKit
import UIKit

class GameScene: SKScene {
    
    var sprite : SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

        backgroundColor = UIColor.blueColor()
        
        let walk = animation()
        
        sprite = SKSpriteNode(imageNamed: "object_icicle00")
        
        walk.set("object_icicle",spriteNode:sprite,play:true,loop:true)
        
        sprite.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        
        //walk.animate(true)

        addChild(sprite)

        

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}