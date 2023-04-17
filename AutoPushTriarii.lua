repeat task.wait() until game:IsLoaded()

game:GetService("Workspace").TowerPlat.TowerPlat.Size = game:GetService("Workspace").TowerPlat.TowerPlat.Size + Vector3.new(999, 0, 999)

vim = game:GetService('VirtualInputManager')

function keypress(key)
   vim:SendKeyEvent(true, key, false, game)
end

function keyrelease(key)
   vim:SendKeyEvent(false, key, false, game)
end


function Teleport(pointB, numSteps, cooldown)
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	local targetPart = Instance.new("Part")
	targetPart.Name = "TargetPart"
	targetPart.Shape = Enum.PartType.Ball
	targetPart.Size = Vector3.new(2, 2, 2)
	targetPart.Anchored = true
	targetPart.CanCollide = false
	targetPart.Transparency = 0
	targetPart.BrickColor = BrickColor.new("Bright violet")
	targetPart.Material = Enum.Material.Neon
	targetPart.Parent = game.Workspace

	local pointA = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
	local currentStep = 0

	local distance = (pointB - pointA).magnitude
	local stepDistance = distance / numSteps
	local cooldownFactor = cooldown

	while currentStep < numSteps do
		local targetPosition = pointA + (pointB - pointA).Unit * (currentStep + 1) * stepDistance

		if currentStep > 0 then
			targetPart:Destroy()
		end

		targetPart = Instance.new("Part")
		targetPart.Name = "TargetPart"
		targetPart.Shape = Enum.PartType.Ball
		targetPart.Size = Vector3.new(2, 2, 2)
		targetPart.Anchored = true
		targetPart.CanCollide = false
		targetPart.Transparency = 0
		targetPart.BrickColor = BrickColor.new("Bright blue")
		targetPart.Material = Enum.Material.Neon
		targetPart.CFrame = CFrame.new(targetPosition)
		targetPart.Parent = game.Workspace

		wait(cooldown)

		humanoid.RootPart.CFrame = CFrame.new(targetPosition)

		currentStep = currentStep + 1

		cooldown = cooldownFactor * (stepDistance / humanoid.WalkSpeed)
	end

	targetPart:Destroy()
end


stand_pos = game:GetService("Workspace").TowerPlat.TowerPlat.Position + Vector3.new(50, 0, 0)
center_pos = game:GetService("Workspace").TowerPlat.TowerPlat.Position
tower_right = game:GetService("Workspace").TowerPlat.TowerPlat.Position + Vector3.new(50, 2, 48)
tower_left = game:GetService("Workspace").TowerPlat.TowerPlat.Position + Vector3.new(50, 2, -48)
def_line_pos = stand_pos + Vector3.new(141.5, 0, 0)
push_pos = stand_pos + Vector3.new(142.5, 3, -5)
tower_line_pos = push_pos + Vector3.new(-70, 0, 0)
_G.go = false
-- Join Battle
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(Character)
wait(5)
Teleport(workspace.Battle.Entergate.InBattleTriger.Position, 15, .5)
_G.go = true
wait(3)
-- godmode
local Lower = game.Players.LocalPlayer.Character.LowerTorso
local Root = Lower.Root

Root.Parent = nil
Root.Parent = Lower

-- noclip 
local Players, Player = game:GetService("Players"), game:GetService("Players").LocalPlayer

if setfflag then
    setfflag("HumanoidParallelRemoveNoPhysics", "False")
    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
end

game:GetService("RunService").Stepped:Connect(
    function()
            for i, v in pairs(Player.Character:GetChildren()) do
                if v:IsA("Humanoid") then
                    v:ChangeState(11)
                end
            end
    end
)
task.spawn(function()
if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.X == 0 then
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end
end)
end)


wait(1)
-- Rejoin on Death
game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid").Died:Connect(function()
wait(5)
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

task.spawn(function()
wait(30)
if not _G.go then
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end
end)
repeat wait() until _G.go

-- Wait for silver and spawn one unit to clean up
wait(18)
task.spawn(function()
print("hi")
while task.wait() do
local args = {
    [1] = 1
}

game:GetService("ReplicatedStorage"):WaitForChild("MQTT"):WaitForChild("battle"):WaitForChild("CallArmyRF"):InvokeServer(unpack(args))
end
end)

-- GoTo Tower Place Pos
Teleport(tower_line_pos, 15, 1)
key = tostring(key)
keypress(Enum.KeyCode.T)
task.wait()
keyrelease(Enum.KeyCode.T)
task.wait(1.5)
keypress(Enum.KeyCode.C)
task.wait()
keyrelease(Enum.KeyCode.C)
-- next
keypress(Enum.KeyCode.Y)
task.wait()
keyrelease(Enum.KeyCode.Y)
task.wait(1.5)
keypress(Enum.KeyCode.C)
task.wait()
keyrelease(Enum.KeyCode.C)
-- next
keypress(Enum.KeyCode.U)
task.wait()
keyrelease(Enum.KeyCode.U)
task.wait(1.5)
keypress(Enum.KeyCode.C)
task.wait()
keyrelease(Enum.KeyCode.C)

-- GoTo Gate and place Defense line
Teleport(def_line_pos, 15, .5)
wait(1)
game:GetService("ReplicatedStorage"):WaitForChild("MQTT"):WaitForChild("battle"):WaitForChild("SetDefenseLineRF"):InvokeServer()
wait()
-- Loop TP closer 
Teleport(push_pos, 25, .5)
while task.wait() do
Teleport(push_pos, 25, 1)
game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid"):MoveTo((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 0, 2)))
game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid"):MoveTo((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 0, -2)))
end
