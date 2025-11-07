local polysilicons = GetParts("Polysilicon")

while true do
	for _, polysilicon in polysilicons do
		polysilicon.PolysiliconMode = if math.random() < 0.01
			then "FlipFlop"
			elseif math.random() > 0.5 then "Activate"
			else "Deactivate"
		polysilicon.Frequency = math.random(1, 10)
		polysilicon:Trigger()
	end

	task.wait()
end
