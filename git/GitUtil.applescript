property git_path : "/usr/local/git/bin/" --to execute git commands we need to call the git commands from this path
(* 
 * Returns current git status
 * @param: local_repo_path is the path to the target repository on your local machine
 * Note: the cd is to move manouver into the local repository path, the ; char ends the call so you can make another call
 * Note: To obtaine a more meaningfull list of items, create a metod that compiles a multidim accociative array derived from the text based staus 
 * Note: Appending -s simplifies the ret msg or you can also use --porcelain which does the same
 *)
on status(local_repo_path, option)
	return do shell script "cd " & local_repo_path & ";" & git_path & "git status" & " " & option
end status
(* 
 * Add a file or many files to a commit
 *@param file_name is the file name you want to add, use * if you want to add all files
 * @example: GitUtils's add(local_repo_path, "*")
 *)
on add(local_repo_path, file_name)
	return do shell script "cd " & local_repo_path & ";" & git_path & git_add & " " & file_name
end add

(* 
 * Commit current changes
 * Note: Commit , usually doesnt return anything
 * @param msg example: "created index.html file"
 * @return example: [master af86d55] added
 * 1 file changed, 0 insertions(+), 0 deletions(-)
 * create mode 100644 error.html
 * @Note: its important that the message is betweentwo single quates
 * @example: GitUtils's commit(local_repo_path, "changes made")
 * Todo: can we also add desscription to a commit?
 * @Note: There is no "extended description" concept in git. Only the commit message. What happens is that the commit message can have a single line or multiple lines External tools or websites such as git-cola or GitHub can interpret multiple lines commit messages as: The first line is a short description All the other lines are an extended description For one line messages, only the "short description" is defined.
 * // :TODO: git commit -m "Title" -m "Description .........." <--this works
 *)
on commit(local_repo_path, message_title, message_description)
	log "message_title: " & message_title
	return do shell script "cd " & local_repo_path & ";" & git_path & "git commit" & " " & "-m" & " '" & message_title & "' " & "-m" & " '" & message_description & "'"
end commit

(*
 * Uploads the current from the local git commits to the remote git
 * @param from_where: "master"
 * @param to_where: "origin"
 * @param remote_repo_url: github.com/user-name/repo-name.git
 * @Note: you may mitigate using username and pass by researching how to use SSH key in github from trusted maschines
 * <<<<<<< HEAD
 * Todo: maybe add try error when doing the shell part
 * =======
 * @example: GitUtils's push(local_repo_path, "github.com/user-name/repo-name.git", user_name, user_password)
 * >>>>>>> origin/master
 *)
on push(local_repo_path, remote_repo_url, user_name, user_password)
	set from_where to "master" --master branch
	set to_where to "https://" & user_name & ":" & user_password & "@" & remote_repo_url --https://user:pass@github.com/user/repo.git--"origin"
	return do shell script "cd " & local_repo_path & ";" & git_path & "git push" & " " & to_where & " " & from_where
end push
--Reset
--the opposite of the add action
--The * resets all
on reset(local_repo_path, file_name)
	return do shell script "cd " & local_repo_path & ";" & git_path & git_reset & " " & file_name
end reset
(*
 * Downloads the current from the remote git to the local git
 * Note: the original git cmd is "git pull origin master"
 * Note: "https://user:pass@github.com/user/repo.git"
 * Note: returns "Already up-to-date." if there are nothing to pull from remote
 * Note: Do we need login and pass for pulling? - for private repos, yes
 *)
on pull(local_repo_path, remote_repo_url, user_name, user_password)
	set from_where to "https://" & user_name & ":" & user_password & "@" & remote_repo_url
	set to_where to "master" --master branch
	return do shell script "cd " & local_repo_path & ";" & git_path & "git pull" & " " & from_where & " " & to_where
end pull
(* 
 * Cherry
 * git cherry -v origin/master
 * Todo: description needed
 * Note: this can be used to assert if there are any local commits ready to be pushed, if there are local commits then text will be returned, if there arent then there will be no text
 *)
on cherry(local_repo_path, user_name, user_password)
	set loc to "origin" --"https://" & user_name & ":" & user_password & "@" & remote_repo_url
	set what_branch to "master" --master branch
	return do shell script "cd " & local_repo_path & ";" & git_path & "git cherry" & " " & loc & "/" & what_branch
end cherry
(*
 * The opposite of the add action
 * "git reset"
 *)
on do_reset()
	
end do_reset

(*
 * --rm --remove files, research this
 *)
on remove()
	
end remove
(*
 * Init
 *)
on init()
	
end init
(*
 * Clone
 * Todo: try to clone a remote REPO 
 *)
on clone()
	
end clone
(* 
 * Get a log of what is new, less verbose with pretty oneline
 * Note: git log --pretty=oneline
 * Note: "pretty=oneline" --get a log of what is new, less verbose with pretty oneline
 * Note: the cmd is: "git log"
 * Note: the do_log name is used because applescript has reserved the log word for its own log method
 *)
on do_log()
	
end do_log
(*
 * set your name and email
 * git config --global user.email you@example.com
 * git config --global user.name "your-user-name"
 *
 *)
on config()
	
end config
(*
 *
 * Note: the digits within the @@ and @@ signs represents indices of the lines that changed. Like: @@ -1 +1,3 @@,do a test with numbered lines from 1 - 16 and remove some to see the meaning like in this research: http://stackoverflow.com/questions/10950412/what-does-1-1-mean-in-gits-diff-output
 * Note: git diff returns a result if a file is removed (the removed file will look like this in the returned result: "--- path-to-removed-file")
 * Note: git diff does not reurn a result if a file is added
 * Note: git diff returns a result if a file is changed (the returned result will contain the lines that changed with a "-" preceding the line that is removed and a "+" preceding the line that is added)
 *)
on diff()
	
end diff


--remote add origin