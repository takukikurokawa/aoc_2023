! AoC Day6 Part2
program fortran2
    integer(8) :: time
    integer(8) :: distance
    integer(8) :: ans = 0
    integer(8) :: high, low, mid
    integer :: i

    time = input()
    distance = input()

    low = time / 2
    high = time
    do while (high - low > 1)
        mid = (high + low) / 2
        if (mid * (time - mid) > distance) then
            low = mid
        else
            high = mid
        end if
    end do
    ans = ans + low

    low = 0
    high = time / 2
    do while (high - low > 1)
        mid = (high + low) / 2
        if (mid * (time - mid) > distance) then
            high = mid
        else
            low = mid
        end if
    end do
    ans = ans - low

    print *, ans

    contains 
    function input() result(res)
        integer(8) :: res
        character(100) :: buf
        character :: c
        integer :: i, len

        res = 0
        read(*, '(A)') buf
        len = len_trim(buf)
        do i = 1, len
            c = buf(i:i)
            if (ichar('0') <= ichar(c) .and. ichar(c) <= ichar('9')) then
                res = 10 * res + ichar(c) - ichar('0')
            end if
        end do
    end function input
end program fortran2
