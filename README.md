# gggolf
gggolf is a team project for CSC444 Software Engineering I course at UofT.

Following is one good practice to git branching: (This is what my friends and I use for our capstone, feel free to change it if you think we can do better)

###Merge steps

1. Create a task in trello
2. git checkout -b ticket_name
3. git push -u origin ticket_name:ticket_name
4. Make changes on the local branch
5. Change file.rb, file2.rb etc
6. Commit the changes to the local branch…
7. push the change to the remote repo a. git push origin
8. After first commit & push, create a new Pull request from github
9. Pull the latest changes from master & merge a. git checkout master b. git pull c. git checkout richard-1-testing d. git rebase master (& squash commits)
10. Make another commit.
11. Push the branch to git hub a. git push -f origin
12. From github on the branch, create a new Pull Request.
13. Send comments or requests for Code Review by adding making comments with @ included at the bottom a. Or by sending the link to ECE496 FB chatting room
14. When the CR is signed off and do the merge directly through github

###Rebase steps
1. git rebase -i master a. fixup the extra commits if you want
2. When conflicts happen 
2.1. resolves the conflict locally,(Head -> master & branch sha -> my code (topic branch))
2.2. git add .
2.3. git rebase --continue
2.4. Or git rebase --abort


Note: I put it in README so that it's easy for people to refer. Later on once everyone is familiar with it, we can place it elsewhere.
