property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt") --prerequisite for loading .applescript files
property ListParser : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "list:ListParser.applescript"))
(*
 * Removes a range of items fromIndex toIndex in theArray
 *)
on remove_range(the_list, from_index, to_index)
	set first_part to (items 1 thru (from_index) of the_list)
	set second_part to (items to_index thru (length of the_list) of the_list)
	return first_part & second_part
end remove_range
(* 
 * Removes an item from the Array at the_index
 * Note: does not modifies the original array
 * TODO: could we redesign this method to actually remove the item on the array, or maybe applescript cant do this? you can replace directly, but maybe not delete directly?
 *)
on remove_at(the_list, the_index)
	if the_index = 1 then
		set new_list to rest of the_list
	else if the_index = length of the_list then
		set new_list to (items 1 thru -2 of the_list)
	else
		set new_list to (items 1 thru (the_index - 1) of the_list) & (items (the_index + 1) thru -1 of the_list)
	end if
	return new_list
end remove_at
(*
 * Note: this the equvilent of pushing an item into an array
 *)
on add_item(the_list, the_item)
	set the_list to the_list & the_item
	return the_list
end add_item
(*
 * Adds a list inside another list, the list is now two dimensional
 * Note: You can also use this to add record's to a list like: {{name:John, title:"Manager", color:"Blue"},{1,2,3}}
 * Example: add_list({1,2,3},{"a","b","c"})--{1,2,3,{"a","b","c"}}
 * Note: if you log the list it will show up as: {1,2,3,"a","b","c"}
 * Note: the length of the returned list in the example above is now 4
 * Note: if you amned the second list directly the length will be 6
 *)
on add_list(a, b)
	set a to a & null --append null to the end of the list so that there is something to replace in the next step
	set last item in a to b
	return a
end add_list
(*
 * Note: if the index is 2 it adds the item just infront of the second item
 *)
on add_at(the_list, the_item, the_index)
	if the_index = 1 then
		set beginning of the_list to the_item
	else if v = (length of the_list) + 1 then
		set end of the_list to the_item
	else
		set the_list to (items 1 thru (the_index - 1) of the_list) & the_item & (items (the_index) thru -1 of the_list)
	end if
	return the_list
end add_at
(*
 * Example: log ArrayModifier's replace({"A", "B", "C", "D", "E"}, "C", "X") --(*A, B, X, D, E*)
 * Note: modifies the original array
 * TODO: add support for not setting the item if there is no match
 *)
on replace(the_list, to_match, replacment)
	set match_index to ListParser's index_of(the_list, to_match)
	set item match_index of the_list to replacment
	return the_list
end replace
(*
 * TODO: make it work even if the length of the array the_replacements is longer than thhe_matches 
 *)
on replace_many(the_list, the_matches, the_replacments)
	repeat with i from 1 to (length of the_matches)
		set the_list to replace(the_list, (item i of the_matches), (item i of the_replacments))
	end repeat
	return the_list
end replace_many
(*
 * swaps an item a in the list with item b
 *)
on swap(the_list, a, b)
	set a_index to ListParser's index_of(the_list, a)
	set b_index to ListParser's index_of(the_list, b)
	if a_index is not null and b_index is not null then
		set item b_index of the_list to a
		set item a_index of the_list to b
	end if
end swap
(*
 * Removes an item from an array
 * Note does not modifies the original array
 *)
on remove(the_list, the_item)
	set match_index to ListParser's index_of(the_list, the_item)
	return remove_at(the_list, match_index)
end remove
(*
 * Removes the_items from the_array
 * Example: log ArrayModifier's removeMany({"a", "b", "c", "d", "e"}, {"b", "d"})--(*a, c, e*)
 *)
on remove_many(the_Array, the_items)
	repeat with i from 1 to (length of the_items)
		set the_Array to remove(the_Array, (item i of the_items))
	end repeat
	return the_Array
end remove_many
(*
 * Returns a list that consits of list a and list b
 * Todo: what happens to the two list after the combination has talen place?
 * Todo: is there an extra seperator at the end? Or is this taken care of?
 * Note: the seperator can be a comma or any other sign
 * Note: i think you can just do: set list_c to list_a & list_b to achive the same result
 *)
on combine(list_a, list_b, seperator)
	set ret_val to {} --establish the return value
	repeat with i from 1 to (length of list_a)
		set the_item to (item i of list_a) & seperator & (item i of list_b) --create the text item
		set ret_val to ret_val & the_item --concat the text item to the list
	end repeat
	return ret_val
end combine
(*
 * Bubble search (alphabetically sorts a list of strings)
 * Note: Alters the original list (make a copy of the original list to preserve the riginal list)
 * Note: Because of the amount of repetition involved, bubble sort is only suitable for sorting small lists. 
 * Note: As lists get larger, bubble sorting becomes too slow to be practical. 
 * Note: You can improve performance by using a more efficient sorting algorithm.
 *)
on bubble_sort(the_list)
	set is_sorted to false
	repeat until is_sorted
		set is_sorted to true
		repeat with i from 1 to (length of the_list) - 1
			if item i of the_list > item (i + 1) of the_list then
				set {item i of the_list, item (i + 1) of the_list} to {item (i + 1) of the_list, item i of the_list}
				set is_sorted to false
			end if
		end repeat
	end repeat
end bubble_sort

--AppleScript supports two assignment operators, set and copy 
--Note:  When applied to complex types (such as list) copy really clones the data, while set only stores a reference. 
on clone(the_list)
	copy the_list to the_copy_list -- copy data 
	return the_copy_list
end clone