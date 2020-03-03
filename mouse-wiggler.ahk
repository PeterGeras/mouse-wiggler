; Mouse Mover Macro

; Variables
minsBreak := 0.1
numLoops := 3

; Constants
msToSec := 1000
secToMin := 60

loop {
	MouseGetPos, xPos, yPos
	MAKECIRCLES(xPos,yPos,numLoops)
	sleep, minsBreak*secToMin*msToSec
}

MAKECIRCLES(xPos,yPos,numLoops) {
	RadToDeg := 0.01745329252
	Radius := 100
	CentreX := xPos
	CentreY := yPos+Radius
	CircleX := 0
	CircleY := 0
	theta := 0
	circles := numLoops*360
	while(theta <= circles) {
		CircleX := Round(CentreX + Radius*Sin(theta*RadToDeg))
		CircleY := Round(CentreY - Radius*Cos(theta*RadToDeg))
		mousemove, CircleX, CircleY, 0
		theta := theta + 5
	}
}	

; Control+Alt+W
^!W::PAUSE