local walkSpeed = 12
local runSpeed = 20
local tweenService = game:GetService('TweenService')
local lp = game.Players.LocalPlayer
local inputService = game:GetService("UserInputService")
local function fetchHumanoid(player)
	
	if player.Character then
		if player.Character:FindFirstChild("Humanoid") then
			if (player.Character:FindFirstChild("Humanoid").ClassName=="Humanoid") then
				return player.Character:FindFirstChild("Humanoid")
			else return "Fail"
			end
		else return "Fail"	
		end
	else return "Fail"	
	end
end
local function setSpeed(player,WS)
	local humanoid = fetchHumanoid(player)
	if humanoid=="Fail" then
		error("Couldn't Find Humanoid")
	else	
		
		tweenService:Create(humanoid,TweenInfo.new(.5 ,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{WalkSpeed=WS}):Play()
		
	end
end
	
local function handleInput(input,inputType,inputDevice)
	if input.KeyCode==Enum.KeyCode.LeftShift or input.KeyCode==Enum.KeyCode.RightShift then
	if inputType=="Start" then
			setSpeed(lp,runSpeed)
			
		elseif inputType == "End" then
			
			setSpeed(lp,walkSpeed)
		end
	end
end

inputService.InputBegan:Connect(function(input)
	handleInput(input,"Start","PC")
end)


inputService.InputEnded:Connect(function(input)
	handleInput(input,"End","PC")
end)

local runService = game:GetService("RunService")

local humanoid = fetchHumanoid(lp)

function updateBobbleEffect()
	local currentTime = tick()
	if humanoid.MoveDirection.Magnitude > 0 then -- we are walking
		local bobbleX = math.cos(currentTime * 10) * .15
		local bobbleY = math.abs(math.sin(currentTime * 10)) * .15

		local bobble = Vector3.new(bobbleX, bobbleY, 0)

		humanoid.CameraOffset = humanoid.CameraOffset:lerp(bobble, .5)
	else -- we are not walking
		humanoid.CameraOffset = humanoid.CameraOffset * .75
	
	end
end

runService.RenderStepped:Connect(updateBobbleEffect)
