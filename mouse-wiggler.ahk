; Mouse Mover Macro
SetDefaultMouseSpeed, 1
SetMouseDelay, 1


; Variables
minsBreak := 0.1
numLoops := 3
radius := 150
degreeTune := 3  ; n degrees per tick

; Constants
msToSec := 1000
secToMin := 60
radToDeg := 0.01745329252
revDegrees := numLoops * 360


; Main

ArrayX_Circle := [],		ArrayY_Circle := []
ArrayX_figureEight := [],	ArrayY_figureEight := []
ArrayX_logSpiral := [],		ArrayY_logSpiral := []

set_circle_offsets(numLoops, radius, degreeTune)
set_figureEight_offsets(numLoops, radius, degreeTune)
set_logSpiral_offsets(numLoops, radius, degreeTune)

loop {
	
	; Log Spiral
	MouseGetPos, xPos, yPos
	make_figure(ArrayX_logSpiral, ArrayY_logSpiral, xPos, yPos)
	sleep, minsBreak*secToMin*msToSec
	; Circle
	MouseGetPos, xPos, yPos
	make_figure(ArrayX_Circle, ArrayY_Circle, xPos, yPos)
	sleep, minsBreak*secToMin*msToSec
	
	; Figure 8
	MouseGetPos, xPos, yPos
	make_figure(ArrayX_figureEight, ArrayY_figureEight, xPos, yPos)
	sleep, minsBreak*secToMin*msToSec	
}


; Setters

set_circle_offsets(numLoops, radius, degreeTune) {
	global ArrayX_Circle, ArrayY_Circle
	global radToDeg, revDegrees
	
	theta := 0
	while(theta <= revDegrees) {
		angle := theta*radToDeg
		x := radius * Sin(angle)
		y := radius * (1-Cos(angle))
		ArrayX_Circle.Push(x)
		ArrayY_Circle.Push(y)
		theta := theta + degreeTune*1.5
	}
}

set_figureEight_offsets(numLoops, radius, degreeTune) {
	global ArrayX_figureEight, ArrayY_figureEight
	global radToDeg, revDegrees
	
	theta := 0
	radius := radius * 2
	while(theta <= revDegrees) {
		angle := theta*radToDeg
		x := radius * Sin(angle)
		y := radius * Sin(angle) * Cos(angle)
		ArrayX_figureEight.Push(x)
		ArrayY_figureEight.Push(y)
		theta := theta + degreeTune
	}
}

set_logSpiral_offsets(numLoops, radius, degreeTune) {
	global ArrayX_logSpiral, ArrayY_logSpiral
	global radToDeg, revDegrees
	
	theta := 0
	radius := radius / 4
	k := 0.2
	switchBack = 0.6
	degreeTuneFactor = 1.5
	while(theta <= revDegrees * switchBack) {
		angle := theta*radToDeg
		x := radius * Exp(k*angle) * Cos(angle)
		y := radius * Exp(k*angle) * Sin(angle)
		ArrayX_logSpiral.Push(x)
		ArrayY_logSpiral.Push(y)
		theta := theta + degreeTune*degreeTuneFactor
	}
	
	; Storing value of angle at halfway to now bring spiral back
	angleSwitchBack := theta*radToDeg
	
	while(theta <= revDegrees * 3 * switchBack) {
		angle := theta*radToDeg
		exponentAngle := 2*angleSwitchBack - angle
		x := radius * Exp(k*exponentAngle) * Cos(angle)
		y := radius * Exp(k*exponentAngle) * Sin(angle)
		ArrayX_logSpiral.Push(x)
		ArrayY_logSpiral.Push(y)
		theta := theta + degreeTune*degreeTuneFactor
	}
	
	; Return to centre, offset = (0,0)
	ArrayX_logSpiral.Push(0)
	ArrayY_logSpiral.Push(0)
}


; Script runners

make_figure(ArrayX, ArrayY, xPos, yPos) {
	numLoops := Min(ArrayX.Length(), ArrayY.Length())
	Loop % numLoops {
		x := xPos + ArrayX[A_Index]
		y := yPos + ArrayY[A_Index]
		mousemove, x, y
	}
}


; Control + Alt + W
^!W::PAUSE
^!R::RELOAD