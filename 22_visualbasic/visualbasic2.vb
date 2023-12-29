' AoC Day22 Part2
Imports System.Collections.Generic

Module VisualBasic2
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

        Public Sub GoDown(dz As Integer)
            z1 -= dz
            z2 -= dz
        End Sub

        Public Overrides Function ToString() As String
            Return String.Format("{0} {1} {2} {3} {4} {5}", x1, y1, z1, x2, y2, z2)
        End Function
    End Class

    Public Class Stack
        Private size As Integer
        Private bricks() As Brick

        Public Sub New(size As Integer, bricks() As Brick)
            Me.size = size
            Me.bricks = bricks
            Array.Sort(Me.bricks, New Comparison(Of Brick)(AddressOf CompareByZ1))
        End Sub

        Public Function Fall(Optional ignore As Integer = -1) As Integer
            Dim fallCount As Integer = 0
            Dim topHeight(size - 1, size - 1) As Integer
            For i As Integer = 0 To bricks.Length() - 1
                If i = ignore Then
                    Continue For
                End If
                Dim height As Integer = 1
                For x As Integer = bricks(i).x1 To bricks(i).x2
                    For y As Integer = bricks(i).y1 To bricks(i).y2
                        height = Math.Max(height, topHeight(x, y) + 1)
                    Next
                Next
                If height < bricks(i).z1 Then
                    bricks(i).GoDown(bricks(i).z1 - height)
                    fallCount += 1
                End If
                For x As Integer = bricks(i).x1 To bricks(i).x2
                    For y As Integer = bricks(i).y1 To bricks(i).y2
                        topHeight(x, y) = height + bricks(i).z2 - bricks(i).z1
                    Next
                Next
            Next
            Return fallCount
        End Function
    End Class

    Sub Main()
        Dim lines() As String = ReadLines()
        Dim ans As Integer = 0
        For i As Integer = 0 To lines.Length() - 1
            Dim bricks() As Brick = Array.ConvertAll(Of String, Brick)(lines, AddressOf ToBrick)
            Dim stack As Stack = new Stack(10, bricks)
            stack.Fall()
            ans += stack.Fall(i)
        Next
        Console.WriteLine(ans)
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
