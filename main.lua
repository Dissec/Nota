-- Made by @Astin
local PaddingX = 15
local GradesWeight = {
    ['D'] = 1,
    ['D+'] = 2,
    ['C'] = 3,
    ['C+'] = 4,
    ['B'] = 5,
    ['B+'] = 7.5,
    ['A-'] = 9,
    ['A'] = 10,
    ['A+'] = 17.5,
    ['S'] = 25
}

local StudentsData = {
    [1] = {
        'B', '1h 3m', 'faust'
    },

    [2] = {
        'B', '1h 22m', 'EmeDeEse'
    },

    [3] = {
        'D+', '1h 41m', 'Noox'
    },

    [4] = {
        'B+', '2h', 'KingamerBR'
    },

    [5] = {
        'A-', '2h 36m', 'LDoguinho'
    },

    [6] = {
        'A+', '3h 50m', 'GOFNY'
    ,

    [7] = {
        'A-', '4h 47m', 'akihirokatsu'
    }
}

local Keys = {
    'Rank', 'Tempo', 'Nome'
}

local Output = ''

function GenerateFloor(Up)
    local Ground = ''
    
    for i=1, PaddingX * #Keys + (#Keys + 1) do
        Ground = Ground..'-'
    end

    if Up then
        Output = Ground..'\n'..Output
    elseif not Up then
        Output = Output..'\n'..Ground..'\n'
    end
end

function GenerateRooms(Hollow, Data)
    if Hollow then
        for Index, Key in pairs(Keys) do
            Output = Output..'|'
            
            for i=1, PaddingX do
                Output = Output..' '
            end
        end
    elseif not Hollow then
        for Index, Key in pairs(Data) do
            Output = Output..'|'

            local Position = math.floor(((PaddingX - string.len(Key)) / 2) + 0.5)
            local Compensation = (PaddingX - Position - string.len(Key))
            
            for i=1, Position do
                Output = Output..' '
            end
            
            Output = Output..Key

            for i=1, Compensation do
                Output = Output..' '
            end
        end
    end

    Output = Output..'|'
end

function Sort()
    table.sort(StudentsData, function(t1, t2)                
       return GradesWeight[t1[1]] > GradesWeight[t2[1]]
    end)
end

function GenerateLeaderboards()
    GenerateFloor(true)
    GenerateRooms(false, Keys)
    Sort()
    
    for Index, Data in ipairs(StudentsData) do
        Output = Output..'\n'
        
        GenerateRooms(false, Data)
    end
    
    GenerateFloor()
end

GenerateLeaderboards()

print(Output)
