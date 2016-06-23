//
//  GameScene.swift
//  runPenguin
//
//  Created by Dev Workstation 01 on 6/21/16.
//  Copyright (c) 2016 Jordan. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var penguin = SKSpriteNode()
    var obstacle = SKSpriteNode()
    
    var actionMoveUp = SKAction()
    var actionMoveDown = SKAction()
    
    var score:Int = 0
    
    let penguinCategory = 0x1 << 1
    let obstacleCategory = 0x1 << 2
    
    let backgroundVelocity: CGFloat = 2.0
    let foregroundVelocity: CGFloat = 13.0

    let obstacleVelocity: CGFloat = 13.0
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
        initlizeScrollingForeground()
        addScore()
        self.addPenguin()
        self.addObstacle()

    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        let jumpSequence = SKAction.sequence([actionMoveUp, actionMoveDown])
            
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.0, initialSpringVelocity: 1.5, options: [], animations: {
            self.penguin.runAction(jumpSequence)
            }, completion: nil)
        
        
    }
   
    func initlizeScrollingForeground() {
        for index in 0 ... 2 {
            let fg = SKSpriteNode(imageNamed: "foreground")
            fg.position = CGPoint(x: index * Int(fg.size.width), y: 96)
            fg.zPosition = -20
            fg.size.height = 575
            fg.anchorPoint = CGPointZero
            fg.name = "foreground"
            self.addChild(fg)
        }

    }
    
    func initializingScrollingBackground() {
        for index in 0 ... 2 {
            let bg = SKSpriteNode(imageNamed: "background")
            bg.position = CGPoint(x: index * Int(bg.size.width), y: 96)
            bg.zPosition = -30
            bg.size.height = 575
            bg.anchorPoint = CGPointZero
            bg.name = "background"
            self.addChild(bg)
        }
    }
    
    func moveForeground() {
        self.enumerateChildNodesWithName("foreground", usingBlock: { (node, stop) -> Void in
            
            if let fg = node as? SKSpriteNode {
                fg.position = CGPoint(x: fg.position.x - self.foregroundVelocity, y: fg.position.y)
                
                // Checks if bg node is completely scrolled off the screen, if yes, then puts it at the end of the other node.
                if fg.position.x <= -fg.size.width {
                    fg.position = CGPointMake(fg.position.x + fg.size.width * 2, fg.position.y)
                }
            }
        })

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
        obstacle.setScale(2.5)
        
        // Adding SpriteKit physics body for collision detection
        obstacle.physicsBody = SKPhysicsBody(texture: obstacleTexture, size: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = UInt32(obstacleCategory)
        obstacle.physicsBody?.dynamic = true
        obstacle.zPosition = -20
        //obstacle.physicsBody?.//
        obstacle.physicsBody?.contactTestBitMask = UInt32(penguinCategory)
        obstacle.physicsBody?.collisionBitMask = 0
        obstacle.physicsBody?.usesPreciseCollisionDetection = true
        obstacle.name = "obstacle"
        
        // Selecting random y position for missile
        obstacle.position = CGPointMake(800, 270)
        self.addChild(obstacle)
    
    }
    func addPenguin() {
        // Initializing spaceship node
        penguin = SKSpriteNode(imageNamed: "penguin")
        
        // May Not be Needed
        penguin.setScale(0.3)
        //penguin.zRotation = CGFloat(-M_PI/2)
        
        // Adding SpriteKit physics body for collision detection
        penguin.physicsBody = SKPhysicsBody(texture: penguinTexture,size: penguin.size)
        penguin.physicsBody?.categoryBitMask = UInt32(penguinCategory)
        penguin.physicsBody?.dynamic = true
        penguin.physicsBody?.contactTestBitMask = UInt32(obstacleCategory)
        penguin.physicsBody?.collisionBitMask = 0
        penguin.physicsBody?.usesPreciseCollisionDetection = true
        penguin.name = "penguin"
        penguin.position = CGPointMake(100, 270)
        
        self.addChild(penguin)
        
        actionMoveUp = SKAction.moveByX(0, y: 250, duration: 0.5)
        actionMoveDown = SKAction.moveByX(0, y: -250, duration: 0.4)
        
        
    }
    
    func addScore() {
        let scoreBox = SKLabelNode()
        
        scoreBox.zPosition = 1
        scoreBox.text = "Score: \(score)"
        scoreBox.fontName = "Chalkduster"
        scoreBox.fontSize = 40
        scoreBox.position = CGPointMake(850, 550)
        scoreBox.name = "scoreBox"
        self.addChild(scoreBox)
        
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
            score += 1
            print(score)
            scene?.childNodeWithName("scoreBox")?.removeFromParent()
            addScore()
            self.addObstacle()
        }
        
        self.moveBackground()
        self.moveForeground()
        self.moveObstacle()
    }
    
}
