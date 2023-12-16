(* AoC Day15 Part2 *)
module StringMap = Map.Make(String)

let rec hash s =
    let n = String.length s in
    if n = 0 then
        0
    else
        (hash (String.sub s 0 (n - 1)) + int_of_char s.[n - 1]) * 17 mod 256

let focal s =
    let n = String.length s in
    if s.[n - 1] = '-' then
        -1
    else
        (int_of_char s.[n - 1]) - (int_of_char '0')

let label s =
    let n = String.length s in
    if s.[n - 1] = '-' then
        String.sub s 0 (n - 1)
    else
        String.sub s 0 (n - 2)

let update s ls mp =
    let l = label s in
    let f = focal s in
    let h = hash l in
    if f = -1 then
        let removed_ls = List.mapi (fun i a ->
            if i = h then
                List.filter (fun x -> x <> l) a
            else
                a
        ) ls in
        (removed_ls, mp)
    else
        let new_mp = StringMap.add l f mp in
        if List.mem l (List.nth ls h) then
            (ls, new_mp)
        else
            let appended_ls = List.mapi (fun i a ->
                if i = h then
                    a @ [l]
                else
                    a
            ) ls in
            (appended_ls, new_mp)

let rec updates t ls mp =
    if t = [] then
        (ls, mp)
    else
        let (new_ls, new_mp) = update (List.hd t) ls mp in
        updates (List.tl t) new_ls new_mp

let rec input s t a =
    let n = String.length s in
    if n = 0 then
        a @ [t]
    else
        let new_s = String.sub s 1 (n - 1) in
        if s.[0] = ',' then
            input new_s "" (a @ [t])
        else
            input new_s (t ^ (String.make 1 s.[0])) a

let solve s =
    let a = input s "" [] in
    let (ls, mp) = updates a (List.init 256 (fun _ -> [])) StringMap.empty in
    let ans = ref 0 in
    for i = 0 to 255 do
        let lsi = List.nth ls i in
        for j = 0 to (List.length lsi) - 1 do
            let f = (Option.value ~default:0 (StringMap.find_opt (List.nth lsi j) mp)) in
            ans := !ans + (i + 1) * (j + 1) * f;
            (*
            print_int i;
            print_newline ();
            print_int j;
            print_newline ();
            print_int (Option.value ~default:0 (StringMap.find_opt (List.nth lsi j) mp));
            print_newline ();
            print_string (List.nth lsi j);
            print_newline ();
            *)
        done
    done;
    !ans;;

let s = read_line () in
let ans = solve s in
print_int ans;
print_newline ();
