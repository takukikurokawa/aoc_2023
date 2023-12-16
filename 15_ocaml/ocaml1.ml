(* AoC Day15 Part1 *)
let hash s =
    let n = String.length s in
    let res = ref 0 in
    for i = 0 to n - 1 do
        let c = int_of_char s.[i] in
        res := (!res + c) * 17 mod 256
    done;
    !res;;

let solve s =
    let n = String.length s in
    let ans = ref 0 in
    let t = ref "" in
    for i = 0 to n do
        if i = n || s.[i] = ',' then begin
            ans := !ans + hash !t;
            t := ""
        end else
            t := !t ^ (String.make 1 s.[i])
    done;
    !ans;;

let s = read_line () in
let ans = solve s in
print_int ans;
print_newline ();
