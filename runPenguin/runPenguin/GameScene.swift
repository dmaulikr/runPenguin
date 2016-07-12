import SpriteKit
import UIKit

class GameScene: SKScene {

    var sprite : SKSpriteNode!
    var animator:UIDynamicAnimator?
    let gravity = UIGravityBehavior()
    let categoryMask:UInt32 = 0b1
    
    var icicleObject: obsticle! = nil
    
    var icicle0 :SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        icicleObject = obsticle()
        
        icicleObject.place(self,x: self.frame.width/2, y: self.frame.height/2)
        
        
        self.physicsWorld.gravity = CGVectorMake(0, -4.9)
        
        
        backgroundColor = UIColor.blueColor()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        icicleObject.Break()
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}