//
//  GameScene.swift
//  runPenguin
//
//  Created by Dev Workstation 01 on 6/21/16.
//  Copyright (c) 2016 Jordan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var penguin = SKSpriteNode()
    var obstacle = SKSpriteNode()
    
    var actionMoveUp = SKAction()
    var actionMoveDown = SKAction()
    
    let penguinCategory = 0x1 << 1
    let obstacleCategory = 0x1 << 2
    
    let backgroundVelocity: CGFloat = 3.0
    let obstacleVelocity: CGFloat = 1.0
    var lastObstacleAdded : NSTimeInterval = 0.0
    
    let obstacleTexture = SKTexture(imageNamed: "obstacle")
    let penguinTexture = SKTexture(imageNamed: "penguin")
    
    override func didMoveToView(view: SKView) {
       
        // Making self delegate of physics world
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        
        /* Setup your scene here */
       
        /*
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPointMake(1050, self.size.height/2)
        background.size.height = 770
        
        addChild(background)
 */
 
        
        self.backgroundColor = SKColor.whiteColor()
        initializingScrollingBackground()
        self.addPenguin()
        self.addObstacle()

    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        penguin.runAction(actionMoveUp)
        
    }
   
    func initializingScrollingBackground() {
        for index in 0 ... 2 {
            let bg = SKSpriteNode(imageNamed: "background")
            bg.position = CGPoint(x: index * Int(bg.size.width), y: 96)
            bg.size.height = 575
            bg.anchorPoint = CGPointZero
            bg.name = "background"
            self.addChild(bg)
        }
    }
    
    func moveBackground() {
        self.enumerateChildNodesWithName("background", usingBlock: { (node, stop) -> Void in
            
            if let bg = node as? SKSpriteNode {
                bg.position = CGPoint(x: bg.position.x - self.backgroundVelocity, y: bg.position.y)
                
                // Checks if bg node is completely scrolled off the screen, if yes, then puts it at the end of the other node.
                if bg.position.x <= -bg.size.width {
                    bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y)
                }
            }
        })
    }
    
    func moveObstacle() {
        self.enumerateChildNodesWithName("obstacle", usingBlock: { (node, stop) -> Void in
            if let obstacle = node as? SKSpriteNode {
                obstacle.position = CGPoint(x: obstacle.position.x - self.obstacleVelocity, y: obstacle.position.y)
                if obstacle.position.x < 0 {
                    obstacle.removeFromParent()
                }
            }
        })
    }
    
    func addObstacle() {
        // Initializing spaceship node
        let obstacle = SKSpriteNode(imageNamed: "obstacle")
        obstacle.setScale(1.5)
        
        // Adding SpriteKit physics body for collision detection
        obstacle.physicsBody = SKPhysicsBody(texture: obstacleTexture, size: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = UInt32(obstacleCategory)
        obstacle.physicsBody?.dynamic = true
        //obstacle.physicsBody?.//
        obstacle.physicsBody?.contactTestBitMask = UInt32(penguinCategory)
        obstacle.physicsBody?.collisionBitMask = 0
        obstacle.physicsBody?.usesPreciseCollisionDetection = true
        obstacle.name = "obstacle"
        
        // Selecting random y position for missile
        obstacle.position = CGPointMake(400, 200)
        self.addChild(obstacle)
    
    }
    func addPenguin() {
        // Initializing spaceship node
        penguin = SKSpriteNode(imageNamed: "penguin")
        
        // May Not be Needed
        penguin.setScale(0.5)
        //penguin.zRotation = CGFloat(-M_PI/2)
        
        // Adding SpriteKit physics body for collision detection
        penguin.physicsBody = SKPhysicsBody(texture: penguinTexture,size: penguin.size)
        penguin.physicsBody?.categoryBitMask = UInt32(penguinCategory)
        penguin.physicsBody?.dynamic = true
        penguin.physicsBody?.contactTestBitMask = UInt32(obstacleCategory)
        penguin.physicsBody?.collisionBitMask = 0
        penguin.physicsBody?.usesPreciseCollisionDetection = true
        penguin.name = "penguin"
        penguin.position = CGPointMake(100, 200)
        
        self.addChild(penguin)
        
        actionMoveUp = SKAction.moveByX(0, y: 30, duration: 0.2)
        actionMoveDown = SKAction.moveByX(0, y: -30, duration: 0.2)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & UInt32(penguinCategory)) != 0 && (secondBody.categoryBitMask & UInt32(obstacleCategory)) != 0 {
            penguin.removeFromParent()
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if currentTime - self.lastObstacleAdded > 1 {
            self.lastObstacleAdded = currentTime + 1
            self.addObstacle()
        }
        
        self.moveBackground()
        self.moveObstacle()
    }
}
