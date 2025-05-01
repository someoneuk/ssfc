
-- configs
local surfacetype = Enum.SurfaceType.Smooth
local allowColor = false
local material = Enum.Material.SmoothPlastic
local modifyMesh = true

-- stuff
local surfaces = {
    "TopSurface",
    "FrontSurface",
    "RightSurface",
    "BottomSurface",
    "BackSurface",
    "LeftSurface"
}

local function setBasepart(part)
    if not part:IsA("BasePart") then return end
    for _, v in pairs(surfaces) do
        part[v] = surfacetype
    end
    if not allowColor then
        part.BrickColor = BrickColor.new("Medium stone grey")
    end
    part.Material = material
end

local function setMesh(mesh)
    if not modifyMesh then return end
    if mesh:IsA("MeshPart") then
        mesh.TextureID = ""
        mesh.MeshId = ""
        mesh.DoubleSided = false
    end
    if mesh:IsA("SpecialMesh") then
        mesh.MeshId = ""
        mesh.TextureId = ""
    end
end

local function setLighting()
    local l = game:GetService("Lighting")
    l.Brightness = 1
    l.Technology = Enum.Technology.Legacy
    l.EnvironmentDiffusescale = 0
    l.EnvironmentSpecularScale = 0
    l.ClockTime = 12
    l.Ambient = Color3.fromRGB(255,255,255)
    l.OutdoorAmbient = Color3.fromRGB(255,255,255)
    local a = l:FindFirstChildWhichIsA("Atmosphere")
    a.AirDensity = 0
    a.Haze = 0
    a.Color = Color3.new(1,1,1)
    a.Glare = 0
    a.Decay = Color3.new(1,1,1)

end

local function check(v)
    if v:IsA("BasePart") then
        setBasepart(v)
    elseif v:IsA("MeshPart") or v:IsA("SpecialMesh") then
        setMesh(v)
    elseif v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("Trail") or v:IsA("SurfaceLight") or v:IsA("PointLight") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v:Destroy()
    end
end

-- fire once
local terrain = game:GetService("Workspace").Terrain
terrain.Decoration = false
terrain.GrassLength = 0
terrain.WaterReflectance = 0
terrain.WaterTransparency = 0
terrain.WaterWaveSize = 0
terrain.WaterWaveSpeed = 1
setLighting()

-- fire
for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
   check(v) 
end

game:GetService("Workspace").DescendantAdded:Connect(function(p)
    check(p)
end)

print("ssfc.13")
