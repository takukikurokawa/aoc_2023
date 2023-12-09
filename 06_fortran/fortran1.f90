! AoC Day6 Part1
program fortran1
    integer, dimension(4) :: time = [41, 66, 72, 66]
    integer, dimension(4) :: distance = [244, 1047, 1228, 1040]
    integer :: i
    integer :: ans = 1

    do i = 1, 4
        ans = ans * cnt(time(i), distance(i))
    end do
    print *, ans
end program fortran1

function cnt(time, distance)
    integer :: calculate
    integer :: time
    integer :: distance
    integer :: t

    cnt = 0
    do t = 0, time
        if ((time - t) * t > distance) then
            cnt = cnt + 1
        end if
    end do
end function cnt
