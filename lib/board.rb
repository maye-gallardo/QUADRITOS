require './lib/point'
require './lib/line'
class Board

    def initialize(rows, columns)
        @rows = rows
        @columns = columns
        @interval = 50
        @points = Array[]
        for i in (1..@rows) do
            for j in (1..@columns) do
                @points.push(Point.new((i*@interval), (j*@interval), 10))
            end
        end
        @horizontalLines = Array[]
        @verticalLines = Array[]
        for i in (1..@rows) do
            for j in (1..@columns-1) do
                @horizontalLines.push(Line.new((j*@interval), ((j+1)*@interval), @interval*i, @interval*i))
                @verticalLines.push(Line.new(@interval*i, @interval*i,(j*@interval), ((j+1)*@interval)))
            end
        end
    end

    def verifySquare(line)
        result = ''
        values = line.split('-')
        orientation = values[0]
        positions =values[1].split('_')
        udpateLine(orientation, positions)
        if(orientation == 'H')
            result = result + "HT-" + verifiyHorizontalLineTop(positions).to_s + "_"
            result = result + "HB-" + verifiyHorizontalLineBotton(positions).to_s + "_"
        else
            result = result + "VR-" + verifyVerticalLineRight(positions).to_s + "_"
            result = result + "VL-" + verifyVerticalLineLeft(positions).to_s + "_"
        end
        return result
    end

    def verifiyHorizontalLineTop(positions)
        topPositionsH = Array[]
        rightPositionsV = Array[]
        leftPositionsV = Array[]
        topPositionsH[0] = positions[0]
        topPositionsH[1] = positions[1]
        topPositionsH[2] = (positions[2].to_i - 50).to_s
        topPositionsH[3] = (positions[3].to_i - 50).to_s
        rightPositionsV[0] = positions[1]
        rightPositionsV[1] = positions[1]
        rightPositionsV[2] = (positions[2].to_i - 50).to_s
        rightPositionsV[3] = positions[3]
        leftPositionsV[0] = positions[0]
        leftPositionsV[1] = positions[0]
        leftPositionsV[2] = (positions[2].to_i - 50).to_s
        leftPositionsV[3] = positions[3]
        return (isLineVisible('H', topPositionsH) && isLineVisible('V', rightPositionsV) && isLineVisible('V', leftPositionsV))
    end

    def verifiyHorizontalLineBotton(positions)
        bottonPositionsH = Array[]
        rightPositionsV = Array[]
        leftPositionsV = Array[]
        bottonPositionsH[0] = positions[0]
        bottonPositionsH[1] = positions[1]
        bottonPositionsH[2] = (positions[2].to_i - 50 + 100).to_s
        bottonPositionsH[3] = (positions[3].to_i - 50 + 100).to_s
        rightPositionsV[0] = positions[1]
        rightPositionsV[1] = positions[1]
        rightPositionsV[2] = positions[2]
        rightPositionsV[3] = (positions[3].to_i - 50 + 100).to_s
        leftPositionsV[0] = positions[0]
        leftPositionsV[1] = positions[0]
        leftPositionsV[2] = positions[2]
        leftPositionsV[3] = (positions[3].to_i - 50 + 100).to_s
        return (isLineVisible('H', bottonPositionsH) && isLineVisible('V', leftPositionsV) && isLineVisible('V', rightPositionsV))
    end

    def verifyVerticalLineRight(positions)
        topPositionsH = Array[]
        bottonPositionsH = Array[]
        rightPositionsV = Array[]
        topPositionsH[0] = (positions[0].to_i - 50).to_s
        topPositionsH[1] = positions[1]
        topPositionsH[2] = positions[2]
        topPositionsH[3] = (positions[3].to_i - 50).to_s
        bottonPositionsH[0] = (positions[0].to_i - 50).to_s
        bottonPositionsH[1] = positions[1]
        bottonPositionsH[2] = (positions[2].to_i - 0 + 50).to_s
        bottonPositionsH[3] = positions[3]
        rightPositionsV[0] = (positions[0].to_i - 50).to_s
        rightPositionsV[1] = (positions[1].to_i - 50).to_s
        rightPositionsV[2] = positions[2]
        rightPositionsV[3] = positions[3]
        return (isLineVisible('H', topPositionsH) && isLineVisible('H', bottonPositionsH) && isLineVisible('V', rightPositionsV))
    end

    def verifyVerticalLineLeft(positions)
        topPositionsH = Array[]
        bottonPositionsH = Array[]
        leftPositionsV = Array[]
        topPositionsH[0] = positions[0]
        topPositionsH[1] = (positions[1].to_i - 0 + 50).to_s
        topPositionsH[2] = positions[2]
        topPositionsH[3] = (positions[3].to_i - 50).to_s
        bottonPositionsH[0] = positions[0]
        bottonPositionsH[1] = (positions[1].to_i - 0 + 50).to_s
        bottonPositionsH[2] = (positions[2].to_i - 0 + 50).to_s
        bottonPositionsH[3] = positions[3]
        leftPositionsV[0] = (positions[0].to_i - 0 + 50).to_s
        leftPositionsV[1] = (positions[1].to_i - 0 + 50).to_s
        leftPositionsV[2] = positions[2]
        leftPositionsV[3] = positions[3]
        return (isLineVisible('H', topPositionsH) && isLineVisible('H', bottonPositionsH) && isLineVisible('V', leftPositionsV))
    end

    def isLineValid(positions)
        positions.each do |position|
            if position.to_i < 50
                return false
            end
        end
        return true
    end

    def isLineVisible(orientation, positions)
        positions = positions[0].to_s + '_' + positions[1].to_s + '_' + positions[2].to_s + '_' + positions[3].to_s
        if(orientation == 'H')
            @horizontalLines.each do |line|
                if(line.getPositions == positions)
                    return line.isItVisible
                end
            end
        else
            @verticalLines.each do |line|
                if(line.getPositions == positions)
                    return line.isItVisible
                end
            end
        end
        return false
    end

    def udpateLine(orientation, positions)
        positions = positions[0].to_s + '_' + positions[1].to_s + '_' + positions[2].to_s + '_' + positions[3].to_s
        if(orientation == 'H')
            @horizontalLines.each do |line|
                if(line.getPositions == positions)
                    line.toVisible
                    break
                end
            end
        else
            @verticalLines.each do |line|
                if(line.getPositions == positions)
                    line.toVisible
                    break
                end
            end
        end
    end

    def getPoints()
        return @points
    end

    def getHorizontalLines()
        return @horizontalLines
    end

    def getVerticalLines()
        return @verticalLines
    end

    def getRows()
        return @rows
    end

    def getColumns()
        return @columns
    end

    def endedTheGame()
        @horizontalLines.each do |line|
            if(!line.isItVisible)
                return false
            end
        end
        @verticalLines.each do |line|
            if(!line.isItVisible)
                return false
            end
        end
        return true
    end

    def getPositionsOfSquare(positions, options)
        values = positions.split('-')
        orientation = values[0]
        positions = values[1]
        positions = positions.split('_')
        options = options.split('_')
        options[0] = options[0].split('-')
        options[1] = options[1].split('-')
        if orientation == 'H'
            if options[0][0] == 'HT' && options[0][1] == 'true'
                return (positions[3].to_i-50).to_s + "-" + positions[0].to_s
            end
            if options[1][0] == 'HB' && options[1][1] == 'true'
                return positions[2].to_s + "-" + positions[0].to_s
            end
        else
            if options[0][0] == 'VR' && options[0][1] == 'true'
                return positions[2].to_s + "-" + (positions[0].to_i-50).to_s
            end
            if options[1][0] == 'VL' && options[1][1] == 'true'
                return positions[2].to_s + "-" + positions[0].to_s
            end
        end
    end

end