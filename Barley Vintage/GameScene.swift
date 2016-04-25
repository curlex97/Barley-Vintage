//
//  GameScene.swift
//  Barley Vintage
//
//  Created by Admin on 19.04.16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

import SpriteKit




class GameScene: SKScene {
    
    let backgroundSprite = SKSpriteNode(imageNamed:"back")
    var tiles : [[SKSpriteNode]] = [[]];
    var ei : Int = 0
    var ej : Int = 0
    var ti : Int = 0
    var tj : Int = 0
    var isMoving : Bool = false
    var count : Int  = 0
    var countLabel : SKLabelNode = SKLabelNode(fontNamed: "Zapfino")
    var newgameLabel : SKLabelNode = SKLabelNode(fontNamed: "Zapfino")
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundSprite.zPosition = -1
        self.backgroundSprite.name = "0"
        self.backgroundSprite.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(self.backgroundSprite)
        
        addTiles()
        //shuffle()
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedRight(_:)))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedLeft(_:)))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedUp(_:)))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedDown(_:)))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!"
//        myLabel.fontSize = 45
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
//        self.addChild(myLabel)
        
        
    }
    
    
    func addTiles()
    {
        count = 0
        countLabel.removeFromParent()
        newgameLabel.removeFromParent()
        
        countLabel.text = String(count)
        newgameLabel.text = "Shuffle"
        
        countLabel.fontSize = 30
        newgameLabel.fontSize = 30
        
        countLabel.name = "count"
        newgameLabel.name = "shuffle"
        
        
        
        countLabel.position = CGPointMake(self.size.width/2, self.size.height - 100)
        newgameLabel.position = CGPointMake(self.size.width/2, 60)

        
        self.addChild(countLabel)
        self.addChild(newgameLabel)
        
        
        for var i in tiles
        {
            for var j in i
            {
                j.removeFromParent()
            }
        }
        
        self.tiles.removeAll()
        
        var names = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
        
        for var i in 0..<4
        {
            var array : [SKSpriteNode] = []
            
            for var j in 0..<4
            {
                let randomIndex = Int(arc4random_uniform(UInt32(names.count)))
                let a = names[randomIndex]
                let sprite = SKSpriteNode(imageNamed: a)
                names.removeAtIndex(randomIndex)
                sprite.xScale = 0.75
                sprite.yScale = 0.75
                sprite.name = String(a)
                array.append(sprite)
                
            }
            self.tiles.append(array)
        }
        
        
        var dy : CGFloat = CGRectGetMidY(self.frame) + 5.0 + tiles.first!.first!.size.height*2.0 + 10.0 - tiles.first!.first!.size.height/2.0;
        
        for var i in 0..<4
        {
            var dx : CGFloat = CGRectGetMidX(self.frame) - 5.0 - tiles.first!.first!.size.width*2.0 - 10.0 + tiles.first!.first!.size.width/2.0;

            for var j in 0..<4
            {
             
                let sprite = self.tiles[i][j]
                sprite.position = CGPointMake(dx, dy)
                dx += tiles.first!.first!.size.width + 10.0
                self.addChild(sprite)
                
            }
            
            dy -= tiles.first!.first!.size.height + 10.0
        }
        
        
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer){
       
        if ej > tj && ei == ti && !isMoving
        {
            isMoving = true
            count += 1
            countLabel.text = String(count)
            var temp = self.tiles[0][0]
            for var i = ej; i > tj; i -= 1
            {
                temp = self.tiles[ei][i]
                //temp.runAction(SKAction.moveToX(temp.position.x - temp.size.width - 10, duration: 0.1))
                self.tiles[ei][i-1].runAction(SKAction.moveToX(self.tiles[ei][i-1].position.x + self.tiles[ei][i-1].size.width + 10, duration: 0.1))
                self.tiles[ei][i] = self.tiles[ei][i-1]
                self.tiles[ei][i-1] = temp
            }
            
            NSLog(self.tiles[ei][tj].name!)
            NSLog(temp.name!)
            
            temp.runAction(SKAction.moveToX(temp.position.x - (temp.size.width + 10) * (CGFloat(ej) - CGFloat(tj)), duration: 0.1))
            
            isMoving = false
            
        }
        
        
       //  NSLog("swiped right")
        
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        
        if ej < tj && ei == ti && !isMoving
        {
            isMoving = true
            count += 1
            countLabel.text = String(count)
            var temp = self.tiles[0][0]
            for var i = ej; i < tj; i += 1
            {
                temp = self.tiles[ei][i]
                //temp.runAction(SKAction.moveToX(temp.position.x + temp.size.width + 10, duration: 0.1))
                self.tiles[ei][i+1].runAction(SKAction.moveToX(self.tiles[ei][i+1].position.x - self.tiles[ei][i+1].size.width - 10, duration: 0.1))
                self.tiles[ei][i] = self.tiles[ei][i+1]
                self.tiles[ei][i+1] = temp
            }
            
            NSLog(self.tiles[ei][tj].name!)
            NSLog(temp.name!)
            
            temp.runAction(SKAction.moveToX(temp.position.x + (temp.size.width + 10) * (CGFloat(tj) - CGFloat(ej)), duration: 0.1))
            isMoving = false
        }
        
       // NSLog("swiped left")
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        
        if ei < ti && ej == tj && !isMoving
        {
            isMoving = true
            count += 1
            countLabel.text = String(count)
            var temp = self.tiles[0][0]
            for var i = ei; i < ti; i += 1
            {
                temp = self.tiles[i][ej]
                //temp.runAction(SKAction.moveToY(temp.position.y + temp.size.height + 10, duration: 0.1))
                self.tiles[i+1][ej].runAction(SKAction.moveToY(self.tiles[i+1][ej].position.y + self.tiles[i+1][ej].size.height + 10, duration: 0.1))
                self.tiles[i][ej] = self.tiles[i+1][ej]
                self.tiles[i+1][ej] = temp
            }
            
            NSLog(self.tiles[ti][ej].name!)
            NSLog(temp.name!)
            temp.runAction(SKAction.moveToY(temp.position.y - (temp.size.height + 10) * (CGFloat(ti) - CGFloat(ei)), duration: 0.1))

            isMoving = false
        }
        
       // NSLog("swiped up")
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        
        if ei > ti && ej == tj && !isMoving
        {
            isMoving = true
            count += 1
            countLabel.text = String(count)
            var temp = self.tiles[0][0]
            
            for var i = ei; i > ti; i -= 1
            {
                temp = self.tiles[i][ej]
                //temp.runAction(SKAction.moveToY(temp.position.y - temp.size.height - 10, duration: 0.1))
                self.tiles[i-1][ej].runAction(SKAction.moveToY(self.tiles[i-1][ej].position.y - self.tiles[i-1][ej].size.height - 10, duration: 0.1))
                self.tiles[i][ej] = self.tiles[i-1][ej]
                self.tiles[i-1][ej] = temp
            }
            
            NSLog(self.tiles[ti][ej].name!)
            NSLog(temp.name!)
            temp.runAction(SKAction.moveToY(temp.position.y + (temp.size.height + 10) * (CGFloat(ei) - CGFloat(ti)), duration: 0.1))
            
            isMoving = false
            
        }
        
       // NSLog("swiped down")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
     
        let location = touches.first!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
     
        if let name = touchedNode.name
        {
            if name == "shuffle"
            {
                addTiles()
            }
        }
        
        for var k in 0..<4
        {
            for var m in 0..<4
            {
                if self.tiles[k][m] == touchedNode && self.tiles[k][m].name != "16"
                {
                    self.ti = k
                    self.tj = m
                    
                    for var i in 0..<4
                    {
                        for var j in 0..<4
                        {
                            if self.tiles[i][j].name == "16"
                            {
                                self.ei = i
                                self.ej = j
                            }
                        }
                        
                    }
                    
                }
            }
        }
        
   //     NSLog("began " + String(ei) + " " + String(ej) + " " + String(ti) + " " + String(tj))
       

        

    }
    
    
    
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
