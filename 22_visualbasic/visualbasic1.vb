' AoC Day22 Part1
Imports System.Collections.Generic

Module VisualBasic1
    Public Class Brick
        Public x1 As Integer
        Public y1 As Integer
        Public z1 As Integer
        Public x2 As Integer
        Public y2 As Integer
        Public z2 As Integer

        Public Sub New(pos() As Integer)
            x1 = pos(0)
            y1 = pos(1)
            z1 = pos(2)
            x2 = pos(3)
            y2 = pos(4)
            z2 = pos(5)
        End Sub

        Public Overrides Function ToString() As String
            Return String.Format("{0} {1} {2} {3} {4} {5}", x1, y1, z1, x2, y2, z2)
        End Function
    End Class

    Public Class Stack
        Private Structure BrickInfo
            Public height As Integer
            Public id As Integer

            Public Sub New(h As Integer, i As Integer)
                height = h
                id = i
            End Sub
        End Structure

        Private info(,) As BrickInfo
        Private nBricks As Integer
        Private immovableBricks As Dictionary(Of Integer, Object)

        Public Sub New(size As Integer)
            ReDim Preserve info(size - 1, size - 1)
            nBricks = 0
            immovableBricks = New Dictionary(Of Integer, Object)()
        End Sub

        Public Sub Fall(brick As Brick)
            Dim id As Integer = nBricks + 1
            nBricks += 1
            Dim height As Integer = 0
            For x As Integer = brick.x1 To brick.x2
                For y As Integer = brick.y1 To brick.y2
                    height = Math.Max(height, info(x, y).height + 1)
                Next
            Next
            Dim supportedBy As New Dictionary(Of Integer, Object)()
            For x As Integer = brick.x1 To brick.x2
                For y As Integer = brick.y1 To brick.y2
                    If info(x, y).height + 1 = height AndAlso info(x, y).id <> 0 Then
                        supportedBy(info(x, y).id) = Nothing
                    End If
                    info(x, y) = New BrickInfo(height + brick.z2 - brick.z1, id)
                Next
            Next
            If supportedBy.Count = 1 Then
                For Each key As Integer In supportedBy.Keys
                    immovableBricks(key) = Nothing
                Next
            End If
        End Sub

        Public Function GetImmovableCount() As Integer
            Return immovableBricks.Count
        End Function
    End Class

    Sub Main()
        Dim lines() As String = ReadLines()
        Dim bricks() As Brick = Array.ConvertAll(Of String, Brick)(lines, AddressOf ToBrick)
        Array.Sort(bricks, New Comparison(Of Brick)(AddressOf CompareByZ1))
        Dim stack As Stack = new Stack(10)
        For Each brick As Brick In bricks
            stack.Fall(brick)
        Next
        Console.WriteLine(bricks.Length() - stack.GetImmovableCount())
    End Sub

    Function ReadLines() As String()
        Dim lines() As String
        Dim n As Integer = 0
        Do
            Dim line As String = Console.ReadLine()
            If String.IsNullOrEmpty(line) Then
                Exit Do
            End If
            ReDim Preserve lines(n)
            lines(n) = line
            n += 1
        Loop
        Return lines
    End Function

    Function ToBrick(s As String) As Brick
        Dim t() As String = s.Replace(",", " ").Replace("~", " ").Split(" "c)
        Dim pos() As Integer = Array.ConvertAll(Of String, Integer)(t, AddressOf Integer.Parse)
        Return New Brick(pos)
    End Function

    Public Function CompareByZ1(x As Brick, y As Brick) As Integer
        Return x.z1.CompareTo(y.z1)
    End Function
End Module
